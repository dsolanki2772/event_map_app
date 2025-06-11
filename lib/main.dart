import 'package:event_map_app/repositories/event_repository.dart';
import 'package:event_map_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/event_bloc.dart';
import 'bloc/event_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Map App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RepositoryProvider(
        create: (_) => EventRepository(),
        child: BlocProvider(
          create: (context) =>
              EventBloc(repository: context.read<EventRepository>())
                ..add(FetchEvents()),
          child: HomeScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
