import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/domain/providers/user_provider.dart';
import 'package:front/features/user/domain/usescases/user/edit_use_cases.dart';
import 'package:front/features/user/presentation/blocs/state/edit/edit_state.dart';
import 'package:front/features/user/presentation/blocs/state/edit_notifier.dart';

final editNotifierProvider =
    StateNotifierProvider<EditNotifier, EditState>((ref) {
  final editProfileUseCases = ref.read(editProfileUseCaseProvider);
  final uploadImageUsecases = ref.read(uploadImageUseCaseProvider);
  final editPasswordUseCases = ref.read(editPasswordUseCaseProvider);

  final editUseCases = EditUseCases(
    editProfileUseCases: editProfileUseCases,
    uploadImageUsecases: uploadImageUsecases,
    editPasswordUseCases: editPasswordUseCases,
  );
  return EditNotifier(editUseCases);
});
