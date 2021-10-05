import 'package:dio/dio.dart';
import 'package:flutter_breaking_youtube/constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      //response is the json data that returned from postman which has status code 200
      Response response = await dio.get('characters');
     // print(response.data.toString());
      return response.data; //list
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      //response is the json data that returned from postman which has status code 200
      Response response = await dio.get('quote',queryParameters: {'author': charName});
      return response.data; //list
    } catch (e) {
      print(e.toString());
      return [];
    }
  }




}

