import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:rotary_flutter/data/model/token.dart';

import '../model/sign_model.dart';

part 'sign_repository.g.dart';

@RestApi()
abstract class SignRepository {
  factory SignRepository(Dio dio, {String baseUrl}) = _SignRepository;

  @POST("/signin")
  Future<TokenModel> signIn(
    @Body() SignModel data
  );

  @POST('/sms/verify')
  Future postSMSVerify(
      @Header('Authorization') String token
      );
}
