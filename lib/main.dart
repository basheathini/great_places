import 'package:flutter/material.dart';
import 'views/places_list_screen.dart';
import 'package:provider/provider.dart';
import 'providers/great_places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlace(),
      child: MaterialApp(
        title: 'Great places',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.lightGreen
        ),
        home: PlacesListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
