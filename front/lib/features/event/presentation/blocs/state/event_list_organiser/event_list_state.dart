import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';

part 'event_list_state.freezed.dart';

@freezed
abstract class EventListState with _$EventListState {
  const factory EventListState.initial() = Initial;
  const factory EventListState.loading() = Loading;
  const factory EventListState.failure(AppException exception) = Failure;
  const factory EventListState.loaded(
      {required List<EventOrganiserModel> events}) = Loaded;
}
