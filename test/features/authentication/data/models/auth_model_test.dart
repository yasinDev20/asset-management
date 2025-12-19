import 'package:assetmanagement/features/authentication/data/models/auth_model.dart';
import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthModel authModel;
  late AuthEntity authEntity;
  late UserModel userModel;
  late UserEntity userEntity;
  late Map<String, dynamic> authMap;

  setUp(() {
    userEntity = UserEntity(
      id: 'id',
      email: 'email',
      name: 'name',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
    );

    userModel = UserModel(
      id: 'id',
      email: 'email',
      name: 'name',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
    );

    authModel = AuthModel(
      user: userModel,
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );

    authEntity = AuthEntity(
      user: userEntity,
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );

    authMap = {
      'user': userModel.toMap(),
      'accessToken': 'accessToken',
      'tokenType': 'tokenType',
      'refreshToken': 'refreshToken',
      'expiresIn': DateTime(2025).toIso8601String(),
      'refreshExpiresAt': DateTime(2025).toIso8601String(),
    };
  });
  test('should return UserEntity', () {
    final authEntityResult = authModel.toEntity();

    final authModelfromEntityResult = AuthModel.fromEntity(authEntity);

    final authMapResult = authModel.toMap();

    final authModelFromMapResult = AuthModel.fromMap(authMap);

    // final userJsonResult = userModel.toJson();
    //final userModelFromJsonResult = UserModel.fromJson(userJson);

    expect(authEntityResult, equals(authEntity));
    expect(authModelfromEntityResult, equals(authModel));
    expect(authMapResult, equals(authMap));
    expect(authModelFromMapResult, authModel);
    // expect(userJsonResult, equals(userJson));
    // expect(userModelFromJsonResult, equals(userModel));
  });
}
