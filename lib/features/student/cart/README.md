# Student Cart Feature

This directory contains the implementation for the student cart feature in the Masarat mobile app.

## API Integration

The implementation integrates with the following endpoint:

```
GET {{baseUrl}}/cart
```

Sample Response:

```json
{
  "success": true,
  "data": {
    "_id": "687eb5af2bc2daf6448d91f0",
    "user": "683f632ebf37309314e5c466",
    "items": [
      {
        "course": {
          "_id": "687a9dda32b602601b156534",
          "title": "test course",
          "instructor": "687a645832b602601b1564d2",
          "coverImageUrl": "default_course_cover.jpg",
          "price": 500
        },
        "price": 500
      }
    ],
    "totalAmount": 500,
    "createdAt": "2025-07-21T21:48:31.463Z",
    "updatedAt": "2025-07-21T21:48:31.463Z",
    "__v": 0
  }
}
```

## File Structure

### Data Layer

#### Models
- `course_cart_model.dart` - Course information in the cart
- `cart_item_model.dart` - Individual cart item containing course and price
- `cart_response_model.dart` - Main cart data model
- `cart_root_response.dart` - API response wrapper

#### API Service
- `student_cart_api_constants.dart` - API endpoint constants
- `student_cart_service.dart` - Retrofit service for cart API calls

#### Repository
- `student_cart_repo.dart` - Repository handling cart data

### Logic Layer (Cubit)
- `student_cart_cubit.dart` - Business logic for cart management
- `student_cart_state.dart` - State management using Freezed

### UI Layer
- `cart_page.dart` - Cart UI implementation

## Usage

To use the cart feature, navigate to the CartPage:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const CartPage()),
);
```

## Features Implemented

- ✅ Fetch cart data from API
- ✅ Display cart items with course details
- ✅ Show total cart amount
- ✅ Loading and error states
- ✅ Retry functionality for failed requests
- ✅ Clean architecture with separation of concerns
- ✅ Empty cart state handling

## Next Steps

1. Implement "Remove from cart" functionality
2. Add "Add to cart" functionality on course details page
3. Implement checkout process
4. Add cart item count display in the app navigation
5. Add unit tests for the cart feature
