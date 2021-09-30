class Character{
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeadOrAlive;
  late List<dynamic> appearanceOfSeasons;
  late  String actorRealName;
  late String categoryOfTwoSeries;
  late  List<dynamic> betterCallSaulAppearance;
  //named constructor
  Character.fromJson(Map<String,dynamic>json){
    charId=json['char_id'];
    name=json['name'];
    nickName=json['nickname'];
    image=json['img'];
    jobs=json['occupation'];
    statusIfDeadOrAlive=json['status'];
    appearanceOfSeasons=json['appearance'];
    actorRealName=json['portrayed'];
    categoryOfTwoSeries=json['category'];
    betterCallSaulAppearance=json['better_call_saul_appearance'];
  }
}