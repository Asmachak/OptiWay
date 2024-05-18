import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/usescases/user/edit_password_use_case.dart';
import 'package:front/features/user/domain/usescases/user/edit_profile_use_case.dart';
import 'package:front/features/user/domain/usescases/user/edit_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/forget_password_use_case.dart';
import 'package:front/features/user/domain/usescases/user/upload_image.dart';
import 'package:front/features/user/presentation/blocs/state/edit/edit_state.dart';

class EditNotifier extends StateNotifier<EditState> {
  final EditUseCases _EditUseCases;

  EditNotifier(
    this._EditUseCases,
  ) : super(const EditState.initial());

  Future<void> editProfile(Map<String, dynamic> body, String id) async {
    state = const EditState.loading();
    final result = await _EditUseCases.editProfileUseCases
        .call(EditProfileParams(body: body, id: id));
    result.fold(
      (failure) => state = EditState.failure(failure),
      (user) {
        state = EditState.success(userModelToEntity(user));
      },
    );
  }

  Future<void> editPassword(Map<String, dynamic> body, String id) async {
    state = const EditState.loading();
    final result = await _EditUseCases.editPasswordUseCases
        .call(EditPasswordParams(body: body, id: id));
    result.fold(
      (failure) => state = EditState.failure(failure),
      (user) {
        state = EditState.success(userModelToEntity(user));
      },
    );
  }

  Future<void> forgetPassword(Map<String, dynamic> body) async {
    state = const EditState.loading();
    final result = await _EditUseCases.forgetPasswordUseCases
        .call(ForgetPasswordParams(body: body));
    result.fold(
      (failure) => state = EditState.failure(failure),
      (user) {
        state = EditState.success(userModelToEntity(user));
      },
    );
  }

  Future<void> uploadImage(File imageFile, String id) async {
    state = const EditState.loading();
    final result = await _EditUseCases.uploadImageUsecases
        .call(UploadImageParams(imageFile: imageFile, id: id));
    result.fold(
      (failure) => state = EditState.failure(failure),
      (user) {
        state = EditState.success(userModelToEntity(user));
      },
    );
  }

  void resetState() {
    state = const EditState.initial();
  }
}
