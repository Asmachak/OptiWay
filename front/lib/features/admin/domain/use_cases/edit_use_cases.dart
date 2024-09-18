import 'package:front/features/admin/domain/use_cases/edit_password_use_case.dart';
import 'package:front/features/admin/domain/use_cases/edit_profile.dart';
import 'package:front/features/admin/domain/use_cases/forget_password_use_case.dart';
import 'package:front/features/admin/domain/use_cases/upload_image_use_case.dart';

class EditAdminUseCases {
  final EditProfileAdminUsecases editProfileUseCases;
  final UploadImageAdminUsecases uploadImageUsecases;
  final EditPasswordAdminUseCase editPasswordUseCases;
  final ForgetPasswordAdminUseCase forgetPasswordUseCases;

  EditAdminUseCases({
    required this.editProfileUseCases,
    required this.uploadImageUsecases,
    required this.editPasswordUseCases,
    required this.forgetPasswordUseCases,
  });
}
