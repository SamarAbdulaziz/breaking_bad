import 'package:bloc/bloc.dart';
import 'package:flutter_breaking_youtube/data/models/characters.dart';
import 'package:flutter_breaking_youtube/data/repositry/charactersRepository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
    List<Character>characters=[];

  List<Character> getAllCharacters(){
  charactersRepository.getAllCharacters().then((characters) {
    print(characters.toList());
    emit(CharactersLoaded(characters));
    this.characters=characters;
  });
 return characters;
}


}

