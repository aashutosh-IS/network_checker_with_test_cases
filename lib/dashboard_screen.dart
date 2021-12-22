import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_logistic_mall/bloc/network_bloc.dart';
import 'package:the_logistic_mall/profile_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is Dashboard'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const ProfileScreen(),
              )),
          child: const Text('Go to Next Screen'),
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
