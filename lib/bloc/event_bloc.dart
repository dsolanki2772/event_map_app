import 'package:bloc/bloc.dart';
import '../models/event_model.dart';
import '../repositories/event_repository.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository repository;
  List<Event> _allEvents = [];

  EventBloc({required this.repository}) : super(EventInitial()) {
    on<FetchEvents>(_onFetchEvents);
    on<ToggleFilter>(_onToggleFilter);
  }

  void _onFetchEvents(FetchEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      _allEvents = await repository.fetchEvents();
      emit(EventLoaded(_allEvents));
    } catch (e) {
      emit(EventError("Failed to load events"));
    }
  }

  void _onToggleFilter(ToggleFilter event, Emitter<EventState> emit) {
    final filtered = event.showUpcoming
        ? _allEvents
              .where(
                (e) => e is ScheduledEvent
                    ? e.isUpcoming
                    : e is CreatedEvent
                    ? e.isUpcoming
                    : false,
              )
              .toList()
        : _allEvents;
    emit(EventLoaded(filtered));
  }
}
