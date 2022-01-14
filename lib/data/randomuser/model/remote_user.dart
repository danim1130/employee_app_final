import 'package:json_annotation/json_annotation.dart';

part 'remote_user.g.dart';

@JsonSerializable()
class RemoteUserResponse{
  final List<RemoteUser> results;

  RemoteUserResponse(this.results);

  dynamic toJson() => _$RemoteUserResponseToJson(this);
  factory RemoteUserResponse.fromJson(dynamic json) => _$RemoteUserResponseFromJson(json);
}

@JsonSerializable()
class RemoteUserName{
  final String title;
  final String first;
  final String last;

  RemoteUserName(this.title, this.first, this.last);

  dynamic toJson() => _$RemoteUserNameToJson(this);
  factory RemoteUserName.fromJson(dynamic json) => _$RemoteUserNameFromJson(json);
}

@JsonSerializable()
class RemoteUserPicture{
  final String large;
  final String medium;
  final String thumbnail;

  RemoteUserPicture(this.large, this.medium, this.thumbnail);

  dynamic toJson() => _$RemoteUserPictureToJson(this);
  factory RemoteUserPicture.fromJson(dynamic json) => _$RemoteUserPictureFromJson(json);
}

@JsonSerializable()
class RemoteUser{
  @JsonKey(defaultValue: RemoteUserGender.etc) final RemoteUserGender gender;
  final RemoteUserName name;
  final String email;
  final String phone;
  final RemoteUserPicture picture;

  RemoteUser(this.gender, this.name, this.email, this.phone, this.picture);

  dynamic toJson() => _$RemoteUserToJson(this);
  factory RemoteUser.fromJson(dynamic json) => _$RemoteUserFromJson(json);
}

enum RemoteUserGender{
  male, female, etc
}