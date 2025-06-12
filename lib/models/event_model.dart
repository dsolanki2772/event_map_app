// event_model.dart
abstract class Event {}

class ScheduledEvent extends Event {
  final String name;
  final DateTime time;

  ScheduledEvent({required this.name, required this.time});

  factory ScheduledEvent.fromJson(Map<String, dynamic> json) {
    return ScheduledEvent(
      name: json['name'],
      time: DateTime.parse(json['time']),
    );
  }

  bool get isUpcoming => time.isAfter(DateTime.now());
}

class CreatedEvent extends Event {
  final String id;
  final String name;
  final int createdAt;

  CreatedEvent({required this.id, required this.name, required this.createdAt});

  factory CreatedEvent.fromJson(Map<String, dynamic> json) {
    return CreatedEvent(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }

  DateTime get createdAtDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);

  bool get isUpcoming => createdAtDateTime.isAfter(DateTime.now());
}

List<Event> parseEvents(List<dynamic> jsonList) {
  return jsonList.map((json) {
    if (json.containsKey('time')) {
      return ScheduledEvent.fromJson(json);
    } else if (json.containsKey('createdAt')) {
      return CreatedEvent.fromJson(json);
    } else {
      throw Exception("Unknown event type");
    }
  }).toList();
}
