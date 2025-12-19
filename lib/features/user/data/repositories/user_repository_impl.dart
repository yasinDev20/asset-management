import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/user/data/models/user_pagination.dart';
import 'package:assetmanagement/features/user/domain/params/user_filter.dart';
import 'package:assetmanagement/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  UserRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, Unit>> addUser(UserEntity userData) async {
    return await runCatching(() async {
      //TODO:buat tanpa register user
      //register user
      final user = await firebaseAuth.signInWithEmailAndPassword(
        email: userData.email,
        password: userData.email,
      );

      //TODO: Buat user dapat melihat lab nya 

      //convert to map
      final userModel = UserModel.fromEntity(
        userData.copyWith(
          id: Uuid().v7(),
          createdAt: DateTime.now().toUtc(),
        ),
      );

      //addUser to collection user with authid to doc id
      await firebaseFirestore
          .collection('users')
          .doc(user.user!.uid)
          .set(userModel.toMap());

      return unit;
    });
  }

  @override
  Future<Either<Failure, UserPaginationResult>> getAllUser({
    required int limit,
    String? lastId,
    required UserFilter? userFilter,
  }) async {
    return await runCatching(() async {
      Query query = firebaseFirestore.collection('users');

      // Tambahkan filter secara dinamis
      if (userFilter != null) {
        if (userFilter.location != null && userFilter.location!.isNotEmpty) {
          query = query.where(
            'locations',
            arrayContainsAny: userFilter.location,
          );
        }

        if (userFilter.name != null && userFilter.name!.isNotEmpty) {
          query = query
              .orderBy('name')
              .where('name', isGreaterThanOrEqualTo: userFilter.name)
              .where('name', isLessThanOrEqualTo: '${userFilter.name}\uf8ff');
        }
      } else {
        //agar orderby tidak 2 kali
        query = query.orderBy('createdAt');
      }

      if (lastId != null) {
        // Ambil DocumentSnapshot dari lastId
        final lastDocSnapshot = await firebaseFirestore
            .collection('users')
            .doc(lastId)
            .get();
        query = query.startAfterDocument(lastDocSnapshot);
      }

      //batasi query
      query = query.limit(limit);

      final querySnapshot = await query.get();

      final userModels = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromMap(data);
      }).toList();

      final userEntities = userModels.map((model) => model.toEntity()).toList();

      // Ambil lastId dari dokumen terakhir
      final String? newLastId = querySnapshot.docs.isNotEmpty
          ? querySnapshot.docs.last.id
          : null;

      return UserPaginationResult(users: userEntities, lastId: newLastId);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    return await runCatching(() async {
      //get documment user
      final query = await firebaseFirestore
          .collection('users')
          .where('id', isEqualTo: id)
          .get();
      final doc = query.docs.first;

      if (!doc.exists) {
        throw AppException(
          type: ExceptionType.auth,
          message: 'User not found after authentication.',
        );
      }

      //Model
      final userModel = UserModel.fromMap(doc.data());

      //Entity
      final userEntity = userModel.toEntity();

      return userEntity;
    });
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword(String email) async {
    return await runCatching(() async {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return unit;
    });
  }
}
