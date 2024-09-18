import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';

class GetAllUsersUseCase {
  final UserRepository userRepository;

  GetAllUsersUseCase(this.userRepository);

  @override
  Future<Either<AppException, List<UserModel>>> call(noParams) async {
    return await userRepository.getUsers();
  }
}

class GetUsersUseCases {
  final GetAllUsersUseCase getAllUsersUseCases;

  GetUsersUseCases({
    required this.getAllUsersUseCases,
  });
}
