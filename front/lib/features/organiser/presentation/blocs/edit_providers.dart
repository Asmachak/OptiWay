import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/domain/providers/organiser_providers.dart';
import 'package:front/features/organiser/domain/use_cases/edit_use_cases.dart';
import 'package:front/features/organiser/presentation/blocs/state/edit/edit_notifier.dart';
import 'package:front/features/organiser/presentation/blocs/state/edit/edit_state.dart';

final editOrganiserNotifierProvider =
    StateNotifierProvider<OrganiserEditNotifier, OrganiserEditState>((ref) {
  final editProfileUseCases = ref.read(editProfileOrganiserUseCaseProvider);
  final uploadImageUsecases = ref.read(uploadImageOrganiserUseCaseProvider);
  final editPasswordUseCases = ref.read(editPasswordOrganiserUseCaseProvider);
  final forgetPasswordUseCases =
      ref.read(forgetPasswordOrganiserUseCaseProvider);

  final editUseCases = EditOrganiserUseCases(
      editProfileUseCases: editProfileUseCases,
      uploadImageUsecases: uploadImageUsecases,
      editPasswordUseCases: editPasswordUseCases,
      forgetPasswordUseCases: forgetPasswordUseCases);
  return OrganiserEditNotifier(editUseCases);
});
