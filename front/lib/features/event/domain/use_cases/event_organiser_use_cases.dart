import 'package:front/features/event/domain/use_cases/add_event_use_case.dart';
import 'package:front/features/event/domain/use_cases/get_event_organiser_use_case.dart';

class EventtOrganiserUseCases {
  final AddEventUsecases addEventUsecases;

  EventtOrganiserUseCases({
    required this.addEventUsecases,
  });
}

class GetEventtOrganiserUseCases {
  final GetEventUsecases getEventUsecases;

  GetEventtOrganiserUseCases({
    required this.getEventUsecases,
  });
}
