import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                key: ValueKey('emailField'),
                controller: emailCtl,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                key: ValueKey('passField'),
                controller: passCtl,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(key: ValueKey('loginButton'), onPressed: () => context.push('/home'), child: Text('Login')),
            ),
          ],
        ),
      ),
    );
  }
}
