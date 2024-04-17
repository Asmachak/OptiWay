import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class EditProfileUsecases implements UseCase<UserModel, EditProfileParams> {
  final UserRepository userRepository;

  EditProfileUsecases(this.userRepository);
  @override
  Future<Either<AppException, UserModel>> call(EditProfileParams params) async {
    return await userRepository.editProfile(body: params.body, id: params.id);
  }
}

class EditProfileParams<T> {
  final String id;
  final Map<String, dynamic> body;
  EditProfileParams({
    required this.body,
    required this.id,
  });
}
