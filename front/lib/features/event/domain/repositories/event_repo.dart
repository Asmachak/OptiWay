import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';

abstract class OrganiserEventRepository {
  Future<Either<AppException, EventOrganiserModel>> addEventOrganiser({
    required Map<String, dynamic> body,
    required String idOrganiser,
    required File imageFile,
  });
  Future<Either<AppException, List<EventOrganiserModel>>> getEventOrganiser({
    required String idOrganiser,
  });
  Future<Either<AppException, String>> deleteEventOrganiser({
    required String idevent,
  });
}
