/*


import 'package:effia_park/domain/repositories/user_repository.dart';
import 'package:effia_park/infrastructure/either.dart';
import 'package:effia_park/infrastructure/exceptions/http_exception.dart';
import 'package:effia_park/shared/models/user/user.dart';
import 'package:effia_park/shared/use_case.dart';


class UpdatePasswordUsecases implements UseCase<User, UpdatePasswordParams<User>>{
  final AuthRepository userRepository;

  UpdatePasswordUsecases(this.userRepository);
@override
  Future<Either<AppException, User>> call(UpdatePasswordParams params) async {
    return await userRepository.changePassword(body:params.body);
  }
}


class UpdatePasswordParams<T> {

  final  Map<String, dynamic> body;
  UpdatePasswordParams({required this.body});
}*/