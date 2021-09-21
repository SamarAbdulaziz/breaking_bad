import 'package:dio/dio.dart';
import 'package:flutter_breaking_youtube/constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,//final baseUrl='https://www.breakingbadapi.com/api/';
      receiveDataWhenStatusError: true,
      // connectTimeout: 20000,
      // receiveTimeout: 20000,
    );
    dio = Dio(options);
  }


  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      //print(response.data.toString());
      return response.data;//list
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
