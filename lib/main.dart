import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:chatbox/Features/Authentication/Riverpod/providers.dart';
import 'package:chatbox/Features/Authentication/Screens/authentication_screen.dart';

import 'package:chatbox/Features/Meetings/Screens/main_bottom_navigation.dart.dart';
import 'package:chatbox/Constant/error.dart';

//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authStateProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatbox',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: authenticationState.when(
        data: (data) {
          if (data != null) {
            return const ButtomNavigationTabs();
          }
          return const AuthenticationScreen();
        },
        error: (error, stackTrace) => ErrorScreen(
          errorText: error.toString(),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
