import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_youtube/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking_youtube/constants/myColors.dart';
import 'package:flutter_breaking_youtube/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Jobs : ', character.jobs.join(' / ')),
                      buildDivider(315),
                      characterInfo(
                          'Appeared in : ', character.categoryOfTwoSeries),
                      buildDivider(250),
                      characterInfo('Season : ',
                          character.appearanceOfSeasons.join(' / ')),
                      buildDivider(280),
                      characterInfo('Status : ', character.statusIfDeadOrAlive),
                      buildDivider(280),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                characterInfo(
                                    'Better call saul appearance : ',
                                    character.betterCallSaulAppearance
                                        .join(' / ')),
                                buildDivider(140),
                              ],
                            ),
                      characterInfo('Actor/Actress : ', character.name),
                      buildDivider(250),
                      SizedBox(
                        height: 20.0,
                      ),
                      //TODO: tomorrow
                      BlocBuilder<CharactersCubit,CharactersState>(
                          builder: (context,state)=>checkIfQuotesAreLoaded(state)
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 500.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      // title: Text('hellooooooo'),//it stays in the same place of the appbar title
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      // title: Text(
      //     'hello'
      // ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

//copied
  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

//copied
  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state){
    if(state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
      }
    else{
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state){
    var quotes = (state).quotes;
if(quotes.length!=0){
  int randomQuoteIndex=Random().nextInt(quotes.length-1);
  return Center(
    child: DefaultTextStyle(
      textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          color: MyColors.myWhite,
          shadows: [
            Shadow(
              color: MyColors.myYellow,
              blurRadius: 7.0,
              offset:Offset (0,0),
            ),
          ]
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            FlickerAnimatedText(
              quotes[randomQuoteIndex].quote,
            ),
          ],
          repeatForever: true,
        ),
    ),
  );
}else{
return Container();
}

  }

  Widget showProgressIndicator(){
    return Center(
        child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ),
    );
  }
}
