import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/domain/providers/event_providers.dart';
import 'package:front/features/event/domain/use_cases/event_organiser_use_cases.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_organiser_notifier.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_state.dart';

final eventNotifierProvider =
    StateNotifierProvider<EventOrganiserNotifier, EventState>((ref) {
  final addEventUseCases = ref.read(addEventOrganiserUseCaseProvider);

  final eventUseCases =
      EventtOrganiserUseCases(addEventUsecases: addEventUseCases);
  return EventOrganiserNotifier(eventUseCases);
});
