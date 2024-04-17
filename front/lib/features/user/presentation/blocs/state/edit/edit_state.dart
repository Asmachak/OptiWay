import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/domain/entities/user_entity.dart';

part 'edit_state.freezed.dart';

@freezed
abstract class EditState with _$EditState {
  const factory EditState.initial() = Initial;
  const factory EditState.loading() = Loading;
  const factory EditState.failure(AppException exception) = Failure;
  const factory EditState.success(UserEntity user) = Success;
}
