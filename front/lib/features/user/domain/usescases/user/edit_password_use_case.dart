import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class EditPasswordUseCase implements UseCase<UserModel, EditPasswordParams> {
  final UserRepository userRepository;

  EditPasswordUseCase(this.userRepository);
  @override
  Future<Either<AppException, UserModel>> call(EditPasswordParams params) async {
    return await userRepository.editPassword(body: params.body, id: params.id);
  }
}

class EditPasswordParams<T> {
  final String id;
  final Map<String, dynamic> body;
  EditPasswordParams({
    required this.body,
    required this.id,
  });
}
