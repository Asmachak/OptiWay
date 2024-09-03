import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/use_cases/edit_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/edit_profile.dart';
import 'package:front/features/organiser/domain/use_cases/edit_use_cases.dart';
import 'package:front/features/organiser/domain/use_cases/forget_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/upload_image_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/edit/edit_state.dart';

class OrganiserEditNotifier extends StateNotifier<OrganiserEditState> {
  final EditOrganiserUseCases _EditUseCases;

  OrganiserEditNotifier(
    this._EditUseCases,
  ) : super(const OrganiserEditState.initial());

  Future<void> editProfile(Map<String, dynamic> body, String id) async {
    state = const OrganiserEditState.loading();
    final result = await _EditUseCases.editProfileUseCases
        .call(OrganiserEditProfileParams(body: body, id: id));
    result.fold(
      (failure) => state = OrganiserEditState.failure(failure),
      (organiser) {
        state = OrganiserEditState.success(organiserModelToEntity(organiser));
      },
    );
  }

  Future<void> editPassword(Map<String, dynamic> body, String id) async {
    state = const OrganiserEditState.loading();
    final result = await _EditUseCases.editPasswordUseCases
        .call(OrganiserEditPasswordParams(body: body, id: id));
    result.fold(
      (failure) => state = OrganiserEditState.failure(failure),
      (organiser) {
        state = OrganiserEditState.success(organiserModelToEntity(organiser));
      },
    );
  }

  Future<void> forgetPassword(Map<String, dynamic> body) async {
    state = const OrganiserEditState.loading();
    final result = await _EditUseCases.forgetPasswordUseCases
        .call(OrganiserForgetPasswordParams(body: body));
    result.fold(
      (failure) => state = OrganiserEditState.failure(failure),
      (organiser) {
        state = OrganiserEditState.success(organiserModelToEntity(organiser));
      },
    );
  }

  Future<void> uploadImage(File imageFile, String id) async {
    state = const OrganiserEditState.loading();
    final result = await _EditUseCases.uploadImageUsecases
        .call(OrganiserUploadImageParams(imageFile: imageFile, id: id));
    result.fold(
      (failure) => state = OrganiserEditState.failure(failure),
      (user) {
        state = OrganiserEditState.success(organiserModelToEntity(user));
      },
    );
  }

  void resetState() {
    state = const OrganiserEditState.initial();
  }
}
