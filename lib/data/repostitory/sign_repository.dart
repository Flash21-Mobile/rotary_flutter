import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/sign_verify_model.dart';

part 'sign_repository.g.dart';

@RestApi()
abstract class SignRepository {
  factory SignRepository(Dio dio, {String baseUrl}) = _SignRepository;

  @POST("/sms")
  Future postSMS(
    @Query('phone') String? phone,
  );

  @POST('/sms/verify')
  Future postSMSVerify(
      @Body() SignVerifyModel data
      );
}
