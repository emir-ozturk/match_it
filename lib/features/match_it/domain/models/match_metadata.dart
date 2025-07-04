import 'dart:convert';

import 'package:equatable/equatable.dart';

class MatchMetadata extends Equatable {
  final String name;
  final int level;
  final int imageCount;
  final String imageFolder;

  const MatchMetadata({
    required this.name,
    required this.level,
    required this.imageCount,
    required this.imageFolder,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'level': level,
      'imageCount': imageCount,
      'imageFolder': imageFolder,
    };
  }

  factory MatchMetadata.fromMap(Map<String, dynamic> map) {
    return MatchMetadata(
      name: map['name'] as String,
      level: map['level'] as int,
      imageCount: map['imageCount'] as int,
      imageFolder: map['imageFolder'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchMetadata.fromJson(String source) =>
      MatchMetadata.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [name, level, imageCount, imageFolder];
}
