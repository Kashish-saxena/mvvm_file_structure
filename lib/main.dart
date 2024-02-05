import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc/api_bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc/update_bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_event/api_event.dart';
import 'package:mvvm_file_structure/core/di/locator.dart';
import 'package:mvvm_file_structure/core/routing/router.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
import 'package:mvvm_file_structure/ui/views/welcome_screen.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ApiBloc()..add(GetApiList())),
        BlocProvider(
          create: (context) => UpdateBloc(),
        ),
      ],
      child: MaterialApp(
        initialRoute: Routes.welcomeScreen,
        onGenerateRoute: PageRoutes.generateRoutes,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}