import 'package:flutter/material.dart';
import 'package:flutter_breaking_youtube/app_router.dart';
import 'package:flutter_breaking_youtube/presentation_ui/screens/characters_screen.dart';

void main() {
  runApp(BreakingBadApp(appRouter: AppRouter(),));//5
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter appRouter;//2 //object to call the method of 'GenerateRoute'

  const BreakingBadApp({Key? key, required this.appRouter}) : super(key: key);//3
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//1
      onGenerateRoute: appRouter.GenerateRoute,//4
    );
  }
}