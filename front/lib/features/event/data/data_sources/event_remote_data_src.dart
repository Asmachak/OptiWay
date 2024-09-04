import 'dart:io';
import 'package:dio/dio.dart';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';

abstract class EventDataSource {
  Future<Either<AppException, EventOrganiserModel>> addEventOrganiser({
    required Map<String, dynamic> body,
    required String idOrganiser,
    required File imageFile,
  });
  Future<Either<AppException, List<EventOrganiserModel>>> getEventOrganiser({
    required String idOrganiser,
  });
  Future<Either<AppException, String>> deleteEventOrganiser({
    required String idEvent,
  });
}

class EventRemoteDataSource implements EventDataSource {
  final NetworkService networkService;

  EventRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, EventOrganiserModel>> addEventOrganiser({
    required Map<String, dynamic> body,
    required String idOrganiser,
    required File imageFile,
  }) async {
    try {
      // Create FormData and add the image file
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last, // Use the actual image name
        ),
      });

      // Add the fields from the body map to FormData
      body.forEach((key, value) {
        if (value != null) {
          formData.fields
              .add(MapEntry(key, value.toString())); // Ensure value is not null
        }
      });

      // Debugging: Log the contents of FormData
      print("FormData fields: ${formData.fields}");
      print("FormData files: ${formData.files}");

      // Send the request with the combined FormData
      final eitherType = await networkService
          .put('/event/addEvent/$idOrganiser', formData: formData);

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final event = EventOrganiserModel.fromJson(response.data);
          return Right(event);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nEventRemoteDataSource.addEvent',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<EventOrganiserModel>>> getEventOrganiser({
    required String idOrganiser,
  }) async {
    try {
      final eitherType =
          await networkService.get('/event/getEvent/$idOrganiser');

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          List<EventOrganiserModel> events = [];
          if (response.data != null) {
            events = List<EventOrganiserModel>.from(
                response.data.map((x) => EventOrganiserModel.fromJson(x)));
          }
          return Right(events);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nEventRemoteDataSource.getEvent',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, String>> deleteEventOrganiser({
    required String idEvent,
  }) async {
    try {
      final eitherType =
          await networkService.delete('/event/deleteEvent/$idEvent');

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          return Right(response.data);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nEventRemoteDataSource.deleteEvent',
        ),
      );
    }
  }
}
