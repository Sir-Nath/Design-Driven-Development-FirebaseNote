import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_firebase_ddd/application/auth/auth_bloc.dart';
import 'package:notepad_firebase_ddd/presentation/route/route.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(listener: (context, state){
      if(state is InitialState){

      }else if(state is AuthenticatedState){
        log('hello');
        //AutoRouter.of(context).replaceNamed(path)
      }else if(state is UnauthenticatedState){
        AutoRouter.of(context).replaceNamed('/sign-in-page');
      }

    },
    child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
    ),
    );
  }
}
