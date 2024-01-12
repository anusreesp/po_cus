import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp>{
  const TimestampConverter();


  @override
  DateTime fromJson(Timestamp timestamp){
    // Timestamp timestamp = json as Timestamp;
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime json) => Timestamp.fromDate(json);

}