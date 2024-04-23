import 'package:front/features/user/domain/usescases/user/edit_password_use_case.dart';
import 'package:front/features/user/domain/usescases/user/edit_profile_use_case.dart';
import 'package:front/features/user/domain/usescases/user/forget_password_use_case.dart';
import 'package:front/features/user/domain/usescases/user/upload_image.dart';

class EditUseCases {
  final EditProfileUsecases editProfileUseCases;
  final UploadImageUsecases uploadImageUsecases;
  final EditPasswordUseCase editPasswordUseCases;
  final ForgetPasswordUseCase forgetPasswordUseCases;

  EditUseCases({
    required this.editProfileUseCases,
    required this.uploadImageUsecases,
    required this.editPasswordUseCases,
    required this.forgetPasswordUseCases,
  });
}
