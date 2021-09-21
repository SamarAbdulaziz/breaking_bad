import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_youtube/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking_youtube/constants/strings.dart';
import 'package:flutter_breaking_youtube/data/repositry/charactersRepository.dart';
import 'package:flutter_breaking_youtube/data/web_services_APIs/charactersWebServises.dart';
import 'package:flutter_breaking_youtube/presentation_ui/screens/character_datail_screen.dart';
import 'package:flutter_breaking_youtube/presentation_ui/screens/characters_screen.dart';

class AppRouter {
   late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

   AppRouter(){
     charactersRepository=CharactersRepository(CharactersWebServices());
     charactersCubit=CharactersCubit(charactersRepository);
   }
  Route? GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(),
        );
    }
  }
}
