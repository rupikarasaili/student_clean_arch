import 'package:flutter/material.dart';
import 'package:student_clean_arch/features/auth/presentation/view/login_view.dart';

import '../features/auth/presentation/view/register_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',

      routes:{
        '/login':(context) => const LoginView(),
        '/register':(context) => const RegisterView(),
      }

      
    );
  }
}