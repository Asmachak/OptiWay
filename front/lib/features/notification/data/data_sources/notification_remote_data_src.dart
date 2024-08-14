import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/notification/data/models/notification_model.dart';
import 'package:front/features/rate/data/models/rate_model.dart';

abstract class NotificationDataSource {
  Future<Either<AppException, List<NotificationModel>>> getNotifications({
    required String userid,
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
}
