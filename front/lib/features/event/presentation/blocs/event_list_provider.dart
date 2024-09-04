import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/domain/providers/event_providers.dart';
import 'package:front/features/event/domain/use_cases/event_organiser_use_cases.dart';
import 'package:front/features/event/presentation/blocs/state/event_list_organiser/event_list_organiser_notifier.dart';
import 'package:front/features/event/presentation/blocs/state/event_list_organiser/event_list_state.dart';

final eventListNotifierProvider =
    StateNotifierProvider<EventListOrganiserNotifier, EventListState>((ref) {
  final getEventUseCases = ref.read(getEventOrganiserUseCaseProvider);

  final eventUseCases =
      GetEventtOrganiserUseCases(getEventUsecases: getEventUseCases);
  return EventListOrganiserNotifier(eventUseCases);
});
