import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../../util/common/common.dart';
import '../../util/model/loadstate.dart';
import '../../util/secure_storage.dart';
import '../interceptor/zstd_interceptor.dart';
import '../model/file/response/file_model.dart';
import '../repostitory/event_repository.dart';
import '../repostitory/file_repository.dart';

class FileAPI {

  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['Accept-Encoding'] = 'zstd'
    ..options.responseType = ResponseType.bytes
    ..options.headers['cheat'] = 'showmethemoney';

  late FileRepository repository;

  FileAPI() {
    dio.interceptors.add(LogInterceptor(
      request: true, // 요청 데이터 로깅
      requestHeader: true, // 요청 헤더 로깅
      requestBody: true, // 요청 바디 로깅
      responseHeader: true, // 응답 헤더 로깅
      responseBody: true, // 응답 바디 로깅
      error: true, // 에러 로깅
    ));
    dio.interceptors.add(ZstdInterceptor());
    repository = FileRepository(dio, baseUrl: serverUrl);
  }

  Future setUpToken() async {
    var token = await globalStorage.read(key: 'token');
    dio.options.headers['Authorization'] = 'bearer $token';
  }

  Future<FileModel?> getAccountFile(int? fileApiPK) async {
    await setUpToken();
    try {
      final result = await repository.getFile('account', fileApiPK);
      return result?.last;
    } catch (e) {
      return null;
    }
  }

  Future postAccountFile(int? fileApiPK, File image) async {
    await setUpToken();
    try {
      await repository.postFile(
          'account', fileApiPK, convertFilesToMultipart([image]));
      return Success('success');
    } catch (e) {
      return Error(e);
    }
  }

  Future<FileModel?> getAdvertiseFile(int? fileApiPK) async {
    await setUpToken();
    try {
      final result = await repository.getFile('advertise', fileApiPK);
      return result?.last;
    } catch (e) {
      return null;
    }
  }

  Future<List<FileModel>?> getMonthlyFile(int? fileApiPK) async {
    await setUpToken();
    try {
      final result = await repository.getFile('monthlyletter', fileApiPK);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<LoadState> postMonthlyLetterFile(int? fileApiPK, String file) async {
    await setUpToken();
    try {
      var convertedFiles = await convertPdfToImages(file);

      await repository.postFile('monthlyletter', fileApiPK, convertFilesToMultipart(convertedFiles));
      return Success('success');
    } catch (e) {
      return Error(e);
    }
  }

  List<MultipartFile> convertFilesToMultipart(List<File> files) {
    return files.map((file) {
      return MultipartFile.fromFileSync(file.path);
    }).toList();
  }

  Future<List<File>> convertPdfToImages(String pdfPath) async {
    final document = await PdfDocument.openFile(pdfPath);
    List<File> imageFiles = [];

    for (int i = 1; i <= document.pagesCount; i++) {
      final page = await document.getPage(i);
      final pageImage = await page.render(
        width: page.width * 1.5,
        height: page.height * 1.5,
        format: PdfPageImageFormat.jpeg, // JPEG 형식으로 변경
      );
      if (pageImage != null) {
        final imageFile = File('$pdfPath-page$i.jpg'); // 파일 확장자도 .jpg로 변경
        await imageFile.writeAsBytes(pageImage.bytes);
        imageFiles.add(imageFile);
      }
      await page.close();
    }

    await document.close();
    return imageFiles;
  }
}
