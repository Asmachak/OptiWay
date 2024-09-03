import 'package:front/features/organiser/domain/use_cases/edit_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/edit_profile.dart';
import 'package:front/features/organiser/domain/use_cases/forget_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/upload_image_use_case.dart';

class EditOrganiserUseCases {
  final EditProfileOrganiserUsecases editProfileUseCases;
  final UploadImageOrganiserUsecases uploadImageUsecases;
  final EditPasswordOrganiserUseCase editPasswordUseCases;
  final ForgetPasswordOrganiserUseCase forgetPasswordUseCases;

  EditOrganiserUseCases({
    required this.editProfileUseCases,
    required this.uploadImageUsecases,
    required this.editPasswordUseCases,
    required this.forgetPasswordUseCases,
  });
}
