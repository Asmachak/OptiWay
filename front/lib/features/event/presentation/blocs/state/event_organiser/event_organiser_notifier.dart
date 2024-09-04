import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/response.dart';
import 'package:front/features/event/domain/use_cases/add_event_use_case.dart';
import 'package:front/features/event/domain/use_cases/delete_event_use_case.dart';
import 'package:front/features/event/domain/use_cases/event_organiser_use_cases.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_state.dart';

class EventOrganiserNotifier extends StateNotifier<EventState> {
  final EventtOrganiserUseCases _eventOrganiserUseCases;

  EventOrganiserNotifier(
    this._eventOrganiserUseCases,
  ) : super(const EventState.initial());

  Future<void> addEvent(
    String idOrganiser,
    Map<String, dynamic> body,
    File imageFile,
  ) async {
    state = const EventState.loading();
    final result = await _eventOrganiserUseCases.addEventUsecases.call(
        AddEventParams(
            body: body, idOrganiser: idOrganiser, imageFile: imageFile));
    result.fold(
      (failure) => state = EventState.failure(failure),
      (event) {
        state = EventState.success(event: event);
      },
    );
  }

  Future<void> deleteEvent(
    String idevent,
  ) async {
    state = const EventState.loading();
    final result = await _eventOrganiserUseCases.deleteEventUsecases
        .call(DeleteEventParams(idevent: idevent));
    result.fold(
      (failure) => state = EventState.failure(failure),
      (response) {
        state = const EventState.deleted();
      },
    );
  }

  void resetState() {
    state = const EventState.initial();
  }
}
