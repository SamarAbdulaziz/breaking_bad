class Quote{
  late String quote;
  late int quoteId;
  late String series;


  Quote.fromJson(Map<String,dynamic>json){
    quote=json['quote'];
    quoteId=json['quote_id'];
    series=json['series'];
  }
}