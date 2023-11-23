import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'authenticator.dart';
import 'main.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  // ref. https://github.com/lucavenir/go_router_riverpod/blob/e1b166c1ebac1e601d0c6eb41bfc379275def76c/example/lib/router/router.dart#L25-L39
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(isAuth.dispose)
    ..listen(
      authenticatorProvider,
      (_, next) {
        isAuth.value = next;
      },
    );

  return GoRouter(
    navigatorKey: routerKey,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: isAuth,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => const HomePage(),
      ),
      GoRoute(
        path: '/signin',
        // TODO(htsuruo): サインアウト時には逆のトランジションアニメーションにしたい
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: '/splash',
        pageBuilder: (context, _) => const NoTransitionPage(
          child: SplashPage(),
        ),
      ),
    ],
    redirect: (context, state) {
      if (isAuth.value.isLoading || !isAuth.value.hasValue) {
        return '/splash';
      }
      final isSignedIn = isAuth.value.requireValue;
      final location = state.uri.toString();
      final isSigninLocation = location == '/signin';
      if (!isSignedIn) {
        return isSigninLocation ? null : '/signin';
      }
      if (isSigninLocation) {
        return '/';
      }
      return null;
    },
  );
}
