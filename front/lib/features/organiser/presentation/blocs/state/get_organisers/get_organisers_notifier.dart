import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/entities/organiser_entity.dart';
import 'package:front/features/organiser/domain/use_cases/get_organisers_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/get_organisers/get_organisers_state.dart';
import 'package:front/shared/use_case.dart';

class GetOrganiserNotifier extends StateNotifier<GetOrganiserState> {
  final GetOrganisersUseCases _getOrganisersUseCases;

  GetOrganiserNotifier(
    this._getOrganisersUseCases,
  ) : super(const GetOrganiserState.initial());

  Future<void> getOrganisers() async {
    state = const GetOrganiserState.loading();
    final result =
        await _getOrganisersUseCases.getOrganisersUseCase.call(NoParams());
    result.fold(
      (failure) => state = GetOrganiserState.failure(failure),
      (userList) {
        // Convert List<UserModel> to List<UserEntity>
        final List<OrganiserEntity> usersEntityList =
            userList.map((user) => organiserModelToEntity(user)).toList();
        state = GetOrganiserState.loaded(list: usersEntityList);
      },
    );
  }
}
