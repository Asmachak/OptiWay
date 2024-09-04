import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/domain/use_cases/event_organiser_use_cases.dart';
import 'package:front/features/event/domain/use_cases/get_event_organiser_use_case.dart';
import 'package:front/features/event/presentation/blocs/state/event_list_organiser/event_list_state.dart';

class EventListOrganiserNotifier extends StateNotifier<EventListState> {
  final GetEventtOrganiserUseCases _eventOrganiserUseCases;

  EventListOrganiserNotifier(
    this._eventOrganiserUseCases,
  ) : super(const EventListState.initial());

  Future<void> getEvent(
    String idOrganiser,
  ) async {
    state = const EventListState.loading();
    final result = await _eventOrganiserUseCases.getEventUsecases
        .call(GetEventParams(idOrganiser: idOrganiser));
    result.fold(
      (failure) => state = EventListState.failure(failure),
      (events) {
        state = EventListState.loaded(events: events);
      },
    );
  }
}
