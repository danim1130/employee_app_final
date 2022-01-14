// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUserResponse _$RemoteUserResponseFromJson(Map<String, dynamic> json) =>
    RemoteUserResponse(
      (json['results'] as List<dynamic>)
          .map((e) => RemoteUser.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$RemoteUserResponseToJson(RemoteUserResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

RemoteUserName _$RemoteUserNameFromJson(Map<String, dynamic> json) =>
    RemoteUserName(
      json['title'] as String,
      json['first'] as String,
      json['last'] as String,
    );

Map<String, dynamic> _$RemoteUserNameToJson(RemoteUserName instance) =>
    <String, dynamic>{
      'title': instance.title,
      'first': instance.first,
      'last': instance.last,
    };

RemoteUserPicture _$RemoteUserPictureFromJson(Map<String, dynamic> json) =>
    RemoteUserPicture(
      json['large'] as String,
      json['medium'] as String,
      json['thumbnail'] as String,
    );

Map<String, dynamic> _$RemoteUserPictureToJson(RemoteUserPicture instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'thumbnail': instance.thumbnail,
    };

RemoteUser _$RemoteUserFromJson(Map<String, dynamic> json) => RemoteUser(
      $enumDecodeNullable(_$RemoteUserGenderEnumMap, json['gender']) ??
          RemoteUserGender.etc,
      RemoteUserName.fromJson(json['name']),
      json['email'] as String,
      json['phone'] as String,
      RemoteUserPicture.fromJson(json['picture']),
    );

Map<String, dynamic> _$RemoteUserToJson(RemoteUser instance) =>
    <String, dynamic>{
      'gender': _$RemoteUserGenderEnumMap[instance.gender],
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'picture': instance.picture,
    };

const _$RemoteUserGenderEnumMap = {
  RemoteUserGender.male: 'male',
  RemoteUserGender.female: 'female',
  RemoteUserGender.etc: 'etc',
};
