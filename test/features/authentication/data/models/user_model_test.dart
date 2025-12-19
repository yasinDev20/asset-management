import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserModel userModel;
  late UserEntity userEntity;
  late Map<String, dynamic> userMap;

  setUp(() {
    userModel = UserModel(
      id: 'id',
      email: 'email',
      name: 'name',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
    );

     userEntity = UserEntity(
      id: 'id',
      email: 'email',
      name: 'name',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
    );

     userMap = {
      'id': 'id',
      'email': 'email',
      'name': 'name',
      'createdAt': '2025-01-01T00:00:00.000',
      'updatedAt': '2025-01-01T00:00:00.000',
    };
  });
  test('should return UserEntity', () {
    

    

    final userEntityResult = userModel.toEntity();

    final userModelfromEntityResult = UserModel.fromEntity(userEntity);

    final userMapResult = userModel.toMap();

    final userModelFromMapResult= UserModel.fromMap(userMap);

    // final userJsonResult = userModel.toJson();
    //final userModelFromJsonResult = UserModel.fromJson(userJson);

    expect(userEntityResult, equals(userEntity));
    expect(userModelfromEntityResult, equals(userModel));
    expect(userMapResult, equals(userMap));
    expect(userModelFromMapResult, userModel);
    // expect(userJsonResult, equals(userJson));
    // expect(userModelFromJsonResult, equals(userModel));
  });
}
