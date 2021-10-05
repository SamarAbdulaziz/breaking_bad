import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_youtube/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking_youtube/constants/myColors.dart';
import 'package:flutter_breaking_youtube/data/models/characters.dart';
import 'package:flutter_breaking_youtube/presentation_ui/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);
  static final routeName = 'CharactersScreen';

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18.0,
        ),
      ),
      onChanged: (characterSearched) {
        addSearchedItemsToSearchedList(characterSearched);
      },
    );
  }

  void addSearchedItemsToSearchedList(String characterSearched) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(characterSearched))
        .toList();
    setState(() {});
  }

  Widget buildAppBarActions() {
    //in the origin app he returns a list <Widget>
    if (isSearching) {
      return IconButton(
        //todo
        onPressed: () {
          clearSearch();
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.clear,
          color: MyColors.myGrey,
        ),
      );
    } else {
      return IconButton(
        //todo
        onPressed: startSearch, // onPressed: (){startSearch();},
        icon: Icon(
          Icons.search,
          color: MyColors.myGrey,
        ),
      );
    }
  }

  void startSearch() {
    //zatona fn //todo search more to understand well
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(
        onRemove: stopSearching,
      ),
    );
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    // i will render th screen without the text in the controller so i need a setState fn
    setState(() {
      searchTextController.clear();
    });
  }

  Widget buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(
        color: MyColors.myGrey,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildAppBarActions()],
        leading: isSearching
            ? BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        backgroundColor: MyColors.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          }else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        //mainAxisExtent: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(), //NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) => CharacterItem(
        character: searchTextController.text.isEmpty
            ? allCharacters[index]
            : searchedForCharacters[index],
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Can\'t connect ... please check your internet connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                color: MyColors.myGrey,
              ),
            ),
            Image.asset('assets/images/no_internet.png'),
          ],
        ),
      ),
    );
  }
}
