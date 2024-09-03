import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/domain/entities/organiser_entity.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class OrganiserAuthState with _$OrganiserAuthState {
  const factory OrganiserAuthState.initial() = Initial;
  const factory OrganiserAuthState.loading() = Loading;
  const factory OrganiserAuthState.failure(AppException exception) = Failure;
  const factory OrganiserAuthState.success() = Success;
  const factory OrganiserAuthState.authenticated({required OrganiserEntity organiser}) =
      Authenticated;
}
