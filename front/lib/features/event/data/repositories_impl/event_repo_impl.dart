import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/data_sources/event_remote_data_src.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';
import 'package:front/features/event/domain/repositories/event_repo.dart';

class OrganiserEventRepositoryImpl implements OrganiserEventRepository {
  final EventRemoteDataSource remoteDataSource;

  OrganiserEventRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, EventOrganiserModel>> addEventOrganiser({
    required Map<String, dynamic> body,
    required String idOrganiser,
    required File imageFile,
  }) async {
    return remoteDataSource.addEventOrganiser(
        body: body, idOrganiser: idOrganiser, imageFile: imageFile);
  }

  @override
  Future<Either<AppException, List<EventOrganiserModel>>> getEventOrganiser(
      {required String idOrganiser}) async {
    return remoteDataSource.getEventOrganiser(idOrganiser: idOrganiser);
  }

  @override
  Future<Either<AppException, String>> deleteEventOrganiser(
      {required String idevent}) async {
    return remoteDataSource.deleteEventOrganiser(idEvent: idevent);
  }
}
