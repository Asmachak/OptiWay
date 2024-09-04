import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/domain/repositories/event_repo.dart';
import 'package:front/shared/use_case.dart';

class DeleteEventUsecases implements UseCase<String, DeleteEventParams> {
  final OrganiserEventRepository eventRepository;

  DeleteEventUsecases(this.eventRepository);
  @override
  Future<Either<AppException, String>> call(DeleteEventParams params) async {
    return await eventRepository.deleteEventOrganiser(idevent: params.idevent);
  }
}

class DeleteEventParams<T> {
  final String idevent;

  DeleteEventParams({required this.idevent});
}
