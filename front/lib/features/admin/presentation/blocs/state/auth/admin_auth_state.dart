import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/domain/entities/admin_entity.dart';

part 'admin_auth_state.freezed.dart';

@freezed
abstract class AdminAuthState with _$AdminAuthState {
  const factory AdminAuthState.initial() = Initial;
  const factory AdminAuthState.loading() = Loading;
  const factory AdminAuthState.failure(AppException exception) = Failure;
  const factory AdminAuthState.success() = Success;
  const factory AdminAuthState.authenticated({required AdminEntity admin}) =
      Authenticated;
}
