import 'package:flutter/material.dart';
import '../sign_in/sign_in_page.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../splash/splash_page.dart';
part 'route.gr.dart';


@MaterialAutoRouter(routes: <AutoRoute>[AutoRoute(page: SignInPage), AutoRoute(page: SplashPage, initial: true)])
class AppRouter extends _$AppRouter{}