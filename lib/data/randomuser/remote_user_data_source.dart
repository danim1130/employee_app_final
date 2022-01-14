import 'package:dio/dio.dart';
import 'package:employee_app/data/randomuser/model/remote_user.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteUserDataSource {
  final Dio _dio;

  RemoteUserDataSource(this._dio);

  Future<List<UserData>> fetchInitialUserList() async {
    var reqResponse = await _dio.get(
      '',
      queryParameters: {
        'results' : 30,
      },
    );
    var rawResponse = reqResponse.data['results'];
    var resultList = (rawResponse as List<dynamic>).map((e) => RemoteUser.fromJson(e)).toList();
    return resultList
        .map(
          (e) => UserData(
            resultList.indexOf(e),
            '${e.name.title} ${e.name.first} ${e.name.last}',
            e.email,
            e.phone,
            resultList.indexOf(e) % 4 == 0
                ? UserStatus.manager
                : UserStatus.worker,
            e.picture.large,
          ),
        )
        .toList();
  }
}
