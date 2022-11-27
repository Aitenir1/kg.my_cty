// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      location: (json['location'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      importance: json['importance'] as bool,
      catergory: json['catergory'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'location': instance.location,
      'importance': instance.importance,
      'catergory': instance.catergory,
      'comments': instance.comments,
    };
