import 'package:bloc/bloc.dart';
import 'package:flutter_breaking_youtube/data/models/characters.dart';
import 'package:flutter_breaking_youtube/data/models/quote.dart';
import 'package:flutter_breaking_youtube/data/repository/charactersRepository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
    List<Character>characters=[];

  List<Character> getAllCharacters(){
  charactersRepository.getAllCharacters().then((characters) {
   //print(characters);//the same list of the character instance that come from repo and its already a list so we don't have to put here .tolist()
    emit(CharactersLoaded(characters));
    this.characters=characters;
  });
 return characters;
}

  void getQuotes(String charName){
    charactersRepository.getAllQuote(charName).then((quotes){
      emit(QuotesLoaded(quotes));
    });
  }

}

