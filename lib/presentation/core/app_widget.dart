import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_firebase_ddd/presentation/route/route.dart';
import '../../application/auth/auth_bloc.dart';
import '../../injection.dart';
//import '../route/route.dart';
import '../sign_in/sign_in_page.dart';
import 'package:auto_route/auto_route.dart';
//import 'package:auto_route_generator/auto_route_generator.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(const AuthCheckRequest()))
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.green[800],
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)
                )
            )
        ),
      ),
    );
  }
}
