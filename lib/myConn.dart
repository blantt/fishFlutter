import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

//dddd
@JsonSerializable()
class User {
  User(this.name, this.assetName);

  String name;
  String assetName;
}
