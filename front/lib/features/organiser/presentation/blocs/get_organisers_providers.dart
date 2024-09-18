import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/domain/providers/organiser_providers.dart';
import 'package:front/features/organiser/domain/use_cases/get_organisers_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/get_organisers/get_organisers_notifier.dart';
import 'package:front/features/organiser/presentation/blocs/state/get_organisers/get_organisers_state.dart';

final getAllOrganisersNotifierProvider =
    StateNotifierProvider<GetOrganiserNotifier, GetOrganiserState>((ref) {
  final getAllOrganisersUseCases = ref.read(getOrganisersUseCaseProvider);

  final getUsersUseCases = GetOrganisersUseCases(
    getOrganisersUseCase: getAllOrganisersUseCases,
  );
  return GetOrganiserNotifier(getUsersUseCases);
});
