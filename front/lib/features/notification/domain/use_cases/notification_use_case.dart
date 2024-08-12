// import 'package:front/core/infrastructure/either.dart';
// import 'package:front/core/infrastructure/exceptions/http_exception.dart';
// import 'package:front/features/notification/data/models/notification_model.dart';
// import 'package:front/features/notification/domain/repositories/notification_repo.dart';
// import 'package:front/features/paiement/data/models/paiement_model.dart';
// import 'package:front/features/paiement/domain/repositories/paiement_repo.dart';

// class NotificationUseCase {
//   final NotificationRepository notificationRepository;

//   NotificationUseCase(this.notificationRepository);

//   @override
//   Future<Either<AppException, void>> call() async {
//     return await notificationRepository.sendNotification();
//   }
// }

// class NotificationParams<T> {
//   final NotificationModel notification;
//   NotificationParams({
//     required this.notification,
//   });
// }
