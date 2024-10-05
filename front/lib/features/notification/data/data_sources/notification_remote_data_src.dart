import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/notification/data/models/notification_model.dart';

abstract class NotificationDataSource {
  Future<Either<AppException, List<NotificationModel>>> getNotifications({
    required String userid,
  });
  Future<Either<AppException, String>> deleteNotification({
    required String id,
  });
}

class NotificationRemoteDataSource implements NotificationDataSource {
  final NetworkService networkService;

  NotificationRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, List<NotificationModel>>> getNotifications({
    required String userid,
  }) async {
    try {
      final eitherType = await networkService.get(
        '/notification/$userid',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          List<NotificationModel> notifications = [];
          if (response.data != null) {
            notifications = List<NotificationModel>.from(
                response.data.map((x) => NotificationModel.fromJson(x)));
          }
          return Right(notifications);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nnotificationRemoteDataSource.GiveRate',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, String>> deleteNotification({
    required String id,
  }) async {
    try {
      final eitherType = await networkService.delete(
        '/deleteNotification/$id',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          if (response.data == "success") {
            return Right(response.data);
          }
          return Left("erreur" as AppException);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nnotificationRemoteDataSource.delete',
        ),
      );
    }
  }
}
