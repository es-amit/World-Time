import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location="";            // Location which is showed on UI
  String time="";
  String flag="";
  String url="";
  bool isDaytime=false;
  WorldTime({required this.location,required this.flag,required this.url});

  Future<void> getTime() async{
    try{
      Response response= await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data= jsonDecode(response.body);

      //getting properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(2,3);
      //print(datetime);
      //print(offset);

      //creating datetime object
      DateTime now = DateTime.parse(datetime);
      now= now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour>6 && now.hour<19 ? true : false;
      //set the time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      time = "Couldn't get data from server";
    }
  }
}
