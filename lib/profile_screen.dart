import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_logistic_mall/base_screen.dart';
import 'package:the_logistic_mall/bloc/network_bloc.dart';
import 'package:the_logistic_mall/listing_screen.dart';
import 'package:the_logistic_mall/model/http_response.dart';
import 'package:the_logistic_mall/repo/mock_repo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is profile Screen'),
      ),
      body: BaseScreen(
        child: Column(
          children: [
            const Text('Base screen with profile'),
            MaterialButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListingScreen(),
                  )),
              child: const Text('Go to Listing Screen'),
              color: Colors.limeAccent,
            ),
          ],
        ),
        noInternetConnectionWidget: const Text(
          'Custom Message if No net',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
