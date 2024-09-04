import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';
import 'package:front/features/event/domain/repositories/event_repo.dart';
import 'package:front/shared/use_case.dart';

class GetEventUsecases
    implements UseCase<List<EventOrganiserModel>, GetEventParams> {
  final OrganiserEventRepository eventRepository;

  GetEventUsecases(this.eventRepository);
  @override
  Future<Either<AppException, List<EventOrganiserModel>>> call(
      GetEventParams params) async {
    return await eventRepository.getEventOrganiser(
      idOrganiser: params.idOrganiser,
    );
  }
}

class GetEventParams<T> {
  final String idOrganiser;
  GetEventParams({required this.idOrganiser});
}
