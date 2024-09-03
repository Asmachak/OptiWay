import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';

part 'event_state.freezed.dart';

@freezed
abstract class EventState with _$EventState {
  const factory EventState.initial() = Initial;
  const factory EventState.loading() = Loading;
  const factory EventState.failure(AppException exception) = Failure;
  const factory EventState.success({required EventOrganiserModel event}) =
      Success;
}
