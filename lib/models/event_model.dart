class Event {
  final String name;
  final String time;

  Event({required this.name, required this.time});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(name: json['name'], time: json['time']);
  }

  bool get isUpcoming {
    try {
      final eventDate = DateTime.parse(time);
      return eventDate.isAfter(DateTime.now());
    } catch (_) {
      return false;
    }
  }
}
