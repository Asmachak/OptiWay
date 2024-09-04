import 'package:front/features/event/domain/use_cases/add_event_use_case.dart';
import 'package:front/features/event/domain/use_cases/delete_event_use_case.dart';
import 'package:front/features/event/domain/use_cases/get_event_organiser_use_case.dart';

class EventtOrganiserUseCases {
  final AddEventUsecases addEventUsecases;
  final DeleteEventUsecases deleteEventUsecases;

  EventtOrganiserUseCases(
      {required this.addEventUsecases, required this.deleteEventUsecases});
}

class GetEventtOrganiserUseCases {
  final GetEventUsecases getEventUsecases;

  GetEventtOrganiserUseCases({
    required this.getEventUsecases,
  });
}
