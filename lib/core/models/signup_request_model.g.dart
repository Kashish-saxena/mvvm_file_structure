// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestModel _$SignUpRequestModelFromJson(Map<String, dynamic> json) =>
    SignUpRequestModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SignUpRequestModelToJson(SignUpRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'status': instance.status,
    };
