import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_logistic_mall/bloc/network_bloc.dart';

import 'dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Connectivity? connectivity;

  const MyApp({Key? key, this.connectivity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
        BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc()..add(ListenConnection()),
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: HomeScreen(),
        ),
        
     ) );
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
