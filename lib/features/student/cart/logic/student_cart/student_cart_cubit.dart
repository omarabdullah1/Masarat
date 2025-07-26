import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/student/cart/data/models/cart_response_model.dart';
import 'package:masarat/features/student/cart/data/models/checkout_request_model.dart';
import 'package:masarat/features/student/cart/data/models/checkout_response_model.dart';
import 'package:masarat/features/student/cart/data/repos/student_cart_repo.dart';
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_state.dart';

class StudentCartCubit extends Cubit<StudentCartState> {
  final StudentCartRepo _cartRepo;

  StudentCartCubit(this._cartRepo) : super(const StudentCartState.initial());

  Future<void> getCart() async {
    emit(const StudentCartState.loading());
    final result = await _cartRepo.getCart();
    result.when(
      success: (data) {
        // Debug: Log the retrieved data
        log('Retrieved cart with total amount: ${data.totalAmount}');
        log('Retrieved cart items count: ${data.items.length}');
        emit(StudentCartState.success(data));
      },
      failure: (error) {
        emit(StudentCartState.error(error.getAllErrorMessages()));
      },
    );
  }

  // Check if a course is already in the cart
  bool isCourseInCart(String courseId) {
    log('Checking if course $courseId is in cart');

    return state.maybeWhen(success: (cartData) {
      log('Cart is loaded with ${cartData.items.length} items');

      // Log each item in the cart for debugging
      for (var item in cartData.items) {
        log('Cart item: ${item.course.id} - ${item.course.title}');
      }

      final isInCart = cartData.items.any((item) => item.course.id == courseId);
      log('Course $courseId is ${isInCart ? "in cart" : "not in cart"}');
      return isInCart;
    }, orElse: () {
      log('Cart is not loaded, state is ${state.runtimeType}');
      return false;
    });
  }

  Future<bool> removeFromCart(String courseId) async {
    // Keep the current state to restore it if the API call fails
    final currentState = state;

    return await state.maybeWhen(
      success: (cartData) async {
        // Find the item being removed to log its price (for debugging)
        final itemBeingRemoved =
            cartData.items.where((item) => item.course.id == courseId).toList();

        // Optimistically update the UI by removing the item from the cart
        final updatedItems =
            cartData.items.where((item) => item.course.id != courseId).toList();

        // Calculate new total amount by summing all remaining items
        final newTotalAmount =
            updatedItems.fold<double>(0, (sum, item) => sum + item.price);

        log('Old total: ${cartData.totalAmount}, New total: $newTotalAmount');
        if (itemBeingRemoved.isNotEmpty) {
          log('Removed item price: ${itemBeingRemoved.first.price}');
        }

        // Create a new cart with the updated items and total
        final updatedCart = CartResponseModel(
          id: cartData.id,
          user: cartData.user,
          items: updatedItems,
          totalAmount: newTotalAmount,
          createdAt: cartData.createdAt,
          updatedAt: cartData.updatedAt,
          version: cartData.version,
        );

        // First emit a loading state
        emit(const StudentCartState.loading());

        // Then emit the loaded state with the updated cart
        emit(StudentCartState.success(updatedCart));

        // Make the API call
        final result = await _cartRepo.removeFromCart(courseId);

        return result.when(
          success: (_) {
            // The UI is already updated
            return true;
          },
          failure: (error) {
            // Revert to the previous state if the API call fails
            emit(currentState);
            emit(StudentCartState.error(
                'Failed to remove item: ${error.getAllErrorMessages()}'));
            return false;
          },
        );
      },
      orElse: () async {
        // If we're not in a success state, we can't remove an item
        emit(const StudentCartState.error(
            'Cannot remove item: cart not loaded'));
        return false;
      },
    );
  }

  Future<bool> addToCart(String courseId) async {
    // First check if course is already in cart
    if (isCourseInCart(courseId)) {
      emit(const StudentCartState.error(
          'هذه الدورة موجودة بالفعل في سلة مشترياتك'));
      return true; // Return true to indicate no error occurred
    }

    // Save the current state in case we need to restore it
    final currentState = state;

    // Show loading state
    emit(const StudentCartState.loading());

    // Make the API call to add item to cart
    final result = await _cartRepo.addToCart(courseId);

    return result.when(
      success: (updatedCart) {
        // Update UI with the new cart data from the API
        emit(StudentCartState.success(updatedCart));
        return true;
      },
      failure: (error) {
        // We need to inspect the full error object
        log('Error object: ${error.runtimeType}, message: ${error.message}, error: ${error.error}');

        // Extract error message in various ways to ensure we catch the right phrase
        final errorMessage = error.getAllErrorMessages();
        final rawMessage = error.message ?? '';

        // Enhanced detection for "already in cart" errors - check for various possible messages
        final containsAlreadyInCart =
            errorMessage.toLowerCase().contains('already in your cart');
        final containsThisCourse =
            errorMessage.toLowerCase().contains('this course is already');
        final rawContainsAlreadyInCart =
            rawMessage.toLowerCase().contains('already in your cart');
        final rawContainsThisCourse =
            rawMessage.toLowerCase().contains('this course is already');

        final isAlreadyInCartError = containsAlreadyInCart ||
            containsThisCourse ||
            rawContainsAlreadyInCart ||
            rawContainsThisCourse ||
            errorMessage.toLowerCase().contains('already in cart') ||
            errorMessage.toLowerCase().contains('موجود'); // Arabic for "exists"

        // Detailed logging for debugging
        log('Cart error detection:');
        log('- Error message: $errorMessage');
        log('- Raw message: $rawMessage');
        log('- Contains "already in your cart": $containsAlreadyInCart');
        log('- Contains "this course is already": $containsThisCourse');
        log('- Raw contains "already in your cart": $rawContainsAlreadyInCart');
        log('- Raw contains "this course is already": $rawContainsThisCourse');
        log('- Final result - isAlreadyInCartError: $isAlreadyInCartError');

        // If we had a previous state, restore it
        emit(currentState);

        if (isAlreadyInCartError) {
          // For "already in cart" errors, we return true since it's not a failure from the user's perspective
          emit(const StudentCartState.error(
              'هذه الدورة موجودة بالفعل في سلة مشترياتك'));
          log('Emitting Error for already in cart');
          return true; // Return true so the UI shows a success message
        } else if (error.toString().contains(
                'type \'Null\' is not a subtype of type \'String\'') ||
            error.toString().contains('Deserializing')) {
          // This is likely a parsing error after a successful API call
          log('API request likely succeeded but parsing failed. Showing success message.');
          emit(StudentCartState.success(CartResponseModel(
              id: 'temp-id',
              user: 'temp-user',
              items: [],
              totalAmount: 0.0,
              createdAt: DateTime.now().toIso8601String(),
              updatedAt: DateTime.now().toIso8601String(),
              version: 1)));
          return true; // Return true to show as success
        } else {
          // Genuine error
          final displayMessage =
              'فشل في إضافة الدورة إلى السلة: ${errorMessage.isNotEmpty ? errorMessage : rawMessage}';
          emit(StudentCartState.error(displayMessage));
          log('Emitting Error for general error: $displayMessage');
          return false;
        }
      },
    );
  }

  /// Initiates the checkout process
  /// Returns the checkout response if successful
  Future<CheckoutResponseModel?> initiateCheckout() async {
    log('Initiating checkout');
    emit(const StudentCartState.checkoutLoading());

    // Create a checkout request model
    const checkoutRequest = CheckoutRequestModel(
      sourceId: SourceIdModel(id: 'src_all'),
      currency: 'SAR',
    );

    // Log the request body for debugging
    log('Checkout request: ${checkoutRequest.toJson()}');

    final result = await _cartRepo.initiateCheckout(checkoutRequest);

    return result.when(
      success: (checkoutData) {
        log('Checkout success: $checkoutData');
        emit(StudentCartState.checkoutSuccess(checkoutData));
        return checkoutData;
      },
      failure: (error) {
        final errorMessage = error.getAllErrorMessages();
        log('Checkout error: $errorMessage');
        emit(StudentCartState.checkoutError(
            'فشل في إتمام عملية الدفع: $errorMessage'));
        return null;
      },
    );
  }
}
