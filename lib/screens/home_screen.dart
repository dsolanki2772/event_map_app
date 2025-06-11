import 'dart:math';
import 'package:event_map_app/bloc/event_bloc.dart';
import 'package:event_map_app/widgets/event_list_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/event_event.dart';
import '../bloc/event_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showUpcoming = false;
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    String style = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_style_dark.json');
    _mapController.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(color: Colors.grey.shade800)),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.search, color: Colors.orange, size: 28),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.place, color: Colors.black, size: 28),
            ),
            Icon(Icons.settings, color: Colors.orange, size: 28),
          ],
        ),
      ),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EventLoaded) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(20.5937, 78.9629),
                    zoom: 4,
                  ),
                  markers: state.events.map((event) {
                    final random = Random();
                    return Marker(
                      markerId: MarkerId(event.time),
                      position: LatLng(
                        20 + random.nextDouble() * 10,
                        70 + random.nextDouble() * 10,
                      ),
                      infoWindow: InfoWindow(title: event.name),
                    );
                  }).toSet(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 60,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Upcoming",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Switch(
                        value: showUpcoming,
                        activeColor: Colors.orange,
                        onChanged: (value) {
                          setState(() {
                            showUpcoming = value;
                          });
                          context.read<EventBloc>().add(ToggleFilter(value));
                        },
                      ),
                    ],
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.3,
                  maxChildSize: 0.7,
                  minChildSize: 0.2,
                  builder: (_, controller) => EventListSheet(
                    events: state.events,
                    controller: controller,
                  ),
                ),
              ],
            );
          } else if (state is EventError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
