import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/domain/providers/admin_providers.dart';
import 'package:front/features/admin/domain/use_cases/edit_use_cases.dart';
import 'package:front/features/admin/presentation/blocs/state/edit/edit_notifier.dart';
import 'package:front/features/admin/presentation/blocs/state/edit/admin_edit_state.dart';

final editAdminNotifierProvider =
    StateNotifierProvider<AdminEditNotifier, AdminEditState>((ref) {
  final editProfileUseCases = ref.read(editProfileAdminUseCaseProvider);
  final uploadImageUsecases = ref.read(uploadImageAdminUseCaseProvider);
  final editPasswordUseCases = ref.read(editPasswordAdminUseCaseProvider);
  final forgetPasswordUseCases = ref.read(forgetPasswordAdminUseCaseProvider);

  final editUseCases = EditAdminUseCases(
      editProfileUseCases: editProfileUseCases,
      uploadImageUsecases: uploadImageUsecases,
      editPasswordUseCases: editPasswordUseCases,
      forgetPasswordUseCases: forgetPasswordUseCases);
  return AdminEditNotifier(editUseCases);
});
