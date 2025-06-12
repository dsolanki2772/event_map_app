import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventRepository {
  final String url =
      'https://6847d529ec44b9f3493e5f06.mockapi.io/api/v1/events';

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(url));
    print("Response:: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return parseEvents(jsonData);
    } else {
      throw Exception('Failed to load events');
    }
  }
}
