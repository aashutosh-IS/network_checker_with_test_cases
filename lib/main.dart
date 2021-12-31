import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_logistic_mall/bloc/network_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:the_logistic_mall/listing_screen.dart';
import 'dashboard_screen.dart';

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  final Connectivity? connectivity;

  const MyApp({Key? key, this.connectivity}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc()..add(ListenConnection()),
        ),
      ],
      child: Scaffold(
        // body: HomeScreen(),
        appBar: AppBar(
          title: const Text('MyApp'),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                key: ValueKey('textfield'),
                decoration: InputDecoration(hintText: "Enter"),
              ),
            ),
            ElevatedButton(
                key: ValueKey("elevBtn"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListingScreen(),
                      ));
                },
                child: Text('Go to Next Screen')),
            Center(
              child: FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.title);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionFailure) {
          //this widget is returned if there's no internet connection
          return const Center(child: Text("No Internet Connection"));
        }
        if (state is ConnectionSuccess) {
          //this is returned if there's internet conmmec
          return const DashBoardScreen();
        } else {
          return const Text("");
        }
      },
    );
  }
}
