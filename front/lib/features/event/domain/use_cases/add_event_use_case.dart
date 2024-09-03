import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';
import 'package:front/features/event/domain/repositories/event_repo.dart';
import 'package:front/shared/use_case.dart';

class AddEventUsecases implements UseCase<EventOrganiserModel, AddEventParams> {
  final OrganiserEventRepository eventRepository;

  AddEventUsecases(this.eventRepository);
  @override
  Future<Either<AppException, EventOrganiserModel>> call(
      AddEventParams params) async {
    return await eventRepository.addEventOrganiser(
        body: params.body,
        idOrganiser: params.idOrganiser,
        imageFile: params.imageFile);
  }
}

class AddEventParams<T> {
  final String idOrganiser;
  final Map<String, dynamic> body;
  final File imageFile;
  AddEventParams(
      {required this.body, required this.idOrganiser, required this.imageFile});
}
