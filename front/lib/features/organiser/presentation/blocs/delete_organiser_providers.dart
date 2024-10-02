import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/domain/providers/organiser_providers.dart';
import 'package:front/features/organiser/domain/use_cases/delete_organiser_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/deleteOrganiser/deleteOrganiser_notifier.dart';
import 'package:front/features/organiser/presentation/blocs/state/deleteOrganiser/delete_organiser_state.dart';

final deleteOrganisersNotifierProvider =
    StateNotifierProvider<DeleteOrganiserNotifier, DeleteOrganiserState>((ref) {
  final deleteOrganisersUseCases = ref.read(deleteOrganisersUseCaseProvider);

  final deleteUsersUseCases =
      DeleteOrganiserUseCases(deleteUseCases: deleteOrganisersUseCases);
  return DeleteOrganiserNotifier(deleteUsersUseCases);
});
