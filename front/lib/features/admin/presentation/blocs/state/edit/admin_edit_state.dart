import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/domain/entities/admin_entity.dart';
part 'admin_edit_state.freezed.dart';

@freezed
abstract class AdminEditState with _$AdminEditState {
  const factory AdminEditState.initial() = Initial;
  const factory AdminEditState.loading() = Loading;
  const factory AdminEditState.failure(AppException exception) = Failure;
  const factory AdminEditState.success(AdminEntity admin) = Success;
}
