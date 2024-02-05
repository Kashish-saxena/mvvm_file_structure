import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'signup_request_model.g.dart';

SignUpRequestModel signUpRequestModelFromJson(String str) =>
    SignUpRequestModel.fromJson(json.decode(str));

String signUpRequestModelToJson(SignUpRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SignUpRequestModel {
  final String? name;
  final String? email;
  final String? gender;
  final String? status;

  SignUpRequestModel({
    this.name,
    this.email,
    this.gender,
    this.status,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);
}
