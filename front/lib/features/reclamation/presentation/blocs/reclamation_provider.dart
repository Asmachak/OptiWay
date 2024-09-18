import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reclamation/domain/providers/reclamation_providers.dart';
import 'package:front/features/reclamation/domain/use_cases/reclamation_use_cases.dart';
import 'package:front/features/reclamation/presentation/blocs/state/reclamation_notifier.dart';
import 'package:front/features/reclamation/presentation/blocs/state/reclamation_state.dart';

final reclamationNotifierProvider =
    StateNotifierProvider<ReclamationNotifier, ReclamationState>((ref) {
  final addReclamationUseCases = ref.read(addReclamationUseCaseProvider);

  final reservationUseCases =
      ReclamationUseCases(addReclamationUseCases: addReclamationUseCases);
  return ReclamationNotifier(reservationUseCases);
});
