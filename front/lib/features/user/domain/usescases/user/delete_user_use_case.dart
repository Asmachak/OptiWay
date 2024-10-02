import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class deleteUserUseCase implements UseCase<String, DeleteUserParams> {
  final UserRepository userRepository;

  deleteUserUseCase(this.userRepository);
  @override
  Future<Either<AppException, String>> call(DeleteUserParams params) async {
    return await userRepository.deleteUser(id: params.id);
  }
}

class DeleteUserParams<T> {
  final String id;
  DeleteUserParams({
    required this.id,
  });
}

class DeleteUseCases {
  final deleteUserUseCase deleteUseCases;

  DeleteUseCases({
    required this.deleteUseCases,
  });
}
