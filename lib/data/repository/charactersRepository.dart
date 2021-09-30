import 'package:flutter_breaking_youtube/data/models/characters.dart';
import 'package:flutter_breaking_youtube/data/web_services_APIs/charactersWebServises.dart';

class CharactersRepository {
  final  CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

   Future<List<Character>> getAllCharacters() async {
    //the variable characters is a list of all data (json)?right????right
    final characters=await charactersWebServices.getAllCharacters();
    //print(characters);
    //the returned list with the details of each object after parsing it by my model
    //the fn.map=>loops on every object of the origin list it knows how to specify each element and convert it to the new list
    //print(characters.map((character) => Character.fromJson(character)).toList()); //it prints the list of Instance of the 'character'
    return characters.map((character) => Character.fromJson(character)).toList();

     }

  }
