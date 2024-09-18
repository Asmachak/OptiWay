import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/use_cases/edit_password_use_case.dart';
import 'package:front/features/admin/domain/use_cases/edit_profile.dart';
import 'package:front/features/admin/domain/use_cases/edit_use_cases.dart';
import 'package:front/features/admin/domain/use_cases/forget_password_use_case.dart';
import 'package:front/features/admin/domain/use_cases/upload_image_use_case.dart';
import 'package:front/features/admin/presentation/blocs/state/edit/admin_edit_state.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/use_cases/edit_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/edit_profile.dart';
import 'package:front/features/organiser/domain/use_cases/forget_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/upload_image_use_case.dart';

class AdminEditNotifier extends StateNotifier<AdminEditState> {
  final EditAdminUseCases _EditUseCases;

  AdminEditNotifier(
    this._EditUseCases,
  ) : super(const AdminEditState.initial());

  Future<void> editProfile(Map<String, dynamic> body, String id) async {
    state = const AdminEditState.loading();
    final result = await _EditUseCases.editProfileUseCases
        .call(AdminEditProfileParams(body: body, id: id));
    result.fold(
      (failure) => state = AdminEditState.failure(failure),
      (admin) {
        state = AdminEditState.success(adminModelToEntity(admin));
      },
    );
  }

  Future<void> editPassword(Map<String, dynamic> body, String id) async {
    state = const AdminEditState.loading();
    final result = await _EditUseCases.editPasswordUseCases
        .call(AdminEditPasswordParams(body: body, id: id));
    result.fold(
      (failure) => state = AdminEditState.failure(failure),
      (admin) {
        state = AdminEditState.success(adminModelToEntity(admin));
      },
    );
  }

  Future<void> forgetPassword(Map<String, dynamic> body) async {
    state = const AdminEditState.loading();
    final result = await _EditUseCases.forgetPasswordUseCases
        .call(AdminForgetPasswordParams(body: body));
    result.fold(
      (failure) => state = AdminEditState.failure(failure),
      (admin) {
        state = AdminEditState.success(adminModelToEntity(admin));
      },
    );
  }

  Future<void> uploadImage(File imageFile, String id) async {
    state = const AdminEditState.loading();
    final result = await _EditUseCases.uploadImageUsecases
        .call(AdminUploadImageParams(imageFile: imageFile, id: id));
    result.fold(
      (failure) => state = AdminEditState.failure(failure),
      (admin) {
        state = AdminEditState.success(adminModelToEntity(admin));
      },
    );
  }

  void resetState() {
    state = const AdminEditState.initial();
  }
}
