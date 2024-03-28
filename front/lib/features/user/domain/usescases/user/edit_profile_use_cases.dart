/*
import 'package:front/features/user/domain/entities/user_entity.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';


class EditProfileUsecases implements UseCase<UserEntity, EditProfileParams>{
  final UserRepository userRepository;

  EditProfileUsecases(this.userRepository);
@override
  Future<Either<AppException, UserEntity>> call(EditProfileParams params) async {
    return await userRepository.editProfile(body:params.body,id: params.id);
  }

}


class EditProfileParams<T> {
final String id;
  final  Map<String, dynamic> body;
  EditProfileParams({required this.body,required this.id,  });
}*/