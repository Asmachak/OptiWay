import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/domain/entities/organiser_entity.dart';

part 'get_organisers_state.freezed.dart';

@freezed
abstract class GetOrganiserState with _$GetOrganiserState {
  const factory GetOrganiserState.initial() = Initial;
  const factory GetOrganiserState.loading() = Loading;
  const factory GetOrganiserState.failure(AppException exception) = Failure;
  const factory GetOrganiserState.loaded(
      {required List<OrganiserEntity> list}) = Loaded;
}
