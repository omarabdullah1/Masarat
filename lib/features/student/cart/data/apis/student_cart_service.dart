import 'package:dio/dio.dart';
import 'package:masarat/features/student/cart/data/apis/student_cart_api_constants.dart';
import 'package:masarat/features/student/cart/data/models/cart_root_response.dart';
import 'package:retrofit/retrofit.dart';

part 'student_cart_service.g.dart';

@RestApi()
abstract class StudentCartService {
  factory StudentCartService(Dio dio, {String baseUrl}) = _StudentCartService;

  @GET(StudentCartApiConstants.getCart)
  Future<CartRootResponse> getCart();

  @DELETE('${StudentCartApiConstants.removeCartItem}/{courseId}')
  Future<dynamic> removeFromCart(@Path('courseId') String courseId);

  @POST(StudentCartApiConstants.addToCart)
  Future<CartRootResponse> addToCart(@Body() Map<String, dynamic> body);
}
