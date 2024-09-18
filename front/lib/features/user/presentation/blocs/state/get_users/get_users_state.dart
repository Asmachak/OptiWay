import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/domain/entities/user_entity.dart';

part 'get_users_state.freezed.dart';

@freezed
abstract class GetUserState with _$GetUserState {
  const factory GetUserState.initial() = Initial;
  const factory GetUserState.loading() = Loading;
  const factory GetUserState.failure(AppException exception) = Failure;
  const factory GetUserState.loaded({required List<UserEntity> list}) = Loaded;
}
