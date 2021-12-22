import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_logistic_mall/bloc/network_bloc.dart';

class BaseScreen extends StatelessWidget {
  final Widget child, noInternetConnectionWidget;
  const BaseScreen(
      {Key? key, required this.child, required this.noInternetConnectionWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is ConnectionFailure) {
            //this widget is returned if there's no internet connection
            return noInternetConnectionWidget;
          }
          if (state is ConnectionSuccess) {
            //this is returned if there's internet conmmec
            return child;
          } else {
            return const Text("");
          }
        },
      ),
    );
  }
}
