import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class Util {
  static String formatDateTime(String rawDate) {
    try {
      final dateTime = DateTime.parse(rawDate).toLocal();
      final formatted = DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
      return formatted;
    } catch (_) {
      return rawDate;
    }
  }

  static Future<BitmapDescriptor> getCustomMarker() async {
    final byteData = await rootBundle.load('assets/marker.png');
    final codec = await ui.instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetWidth: 100,
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
