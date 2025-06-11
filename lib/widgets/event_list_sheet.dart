import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../utils/util.dart';

class EventListSheet extends StatelessWidget {
  final List<Event> events;
  final ScrollController controller;

  const EventListSheet({
    super.key,
    required this.events,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: ListView.builder(
          controller: controller,
          itemCount: events.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, index) {
            final event = events[index];
            final icon = _getEventIcon(index);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.black, size: 20),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          Util.formatDateTime(event.time),
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.orange),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getEventIcon(int index) {
    final icons = [Icons.hiking, Icons.coffee, Icons.music_note, Icons.star];
    return icons[index % icons.length];
  }
}
