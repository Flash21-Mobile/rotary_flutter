import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rotary_flutter/data/model/account/request/account_request_dto.dart';

import '../model/account/response/account_model.dart';

part 'account_repository.g.dart';

@RestApi()
abstract class AccountRepository {
  factory AccountRepository(Dio dio, {String baseUrl}) = _AccountRepository;

  @GET("/account")
  Future<List<Account>> getAccount({
    @Query('cellphone') String? cellphone,
    @Query('size') int? size,
    @Query('matchType') String? matchType
  });

  @PUT("/account/{id}")
  Future<Account> putAccount(@Path("id") int id, @Body() AccountRequestModel account);
}
