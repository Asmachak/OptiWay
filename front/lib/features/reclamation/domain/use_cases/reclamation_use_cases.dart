import 'package:front/features/reclamation/domain/use_cases/add_reclamation_use_case.dart';
import 'package:front/features/reclamation/domain/use_cases/get_reclamation_use_case.dart';

class ReclamationUseCases {
  final AddReclamationUsecases addReclamationUseCases;
  final GetReclamationUsecases getReclamationUseCases;

  ReclamationUseCases(
      {required this.addReclamationUseCases,
      required this.getReclamationUseCases});
}
