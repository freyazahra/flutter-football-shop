// lib/screens/login.dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/screens/main_page.dart'; // Ganti MyHomePage jika nama file kamu berbeda
import 'package:football_shop/config.dart'; // PENTING: Mengambil backendBase

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
            title: const Text('Login'),
            automaticallyImplyLeading: false, // Untuk memastikan ini adalah halaman awal
        ),
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                const SizedBox(height: 30.0),
                                TextField(
                                    controller: _usernameController,
                                    decoration: const InputDecoration(
                                        labelText: 'Username',
                                        border: OutlineInputBorder(),
                                    ),
                                ),
                                const SizedBox(height: 12.0),
                                TextField(
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                        labelText: 'Password',
                                        border: OutlineInputBorder(),
                                    ),
                                    obscureText: true,
                                ),
                                const SizedBox(height: 24.0),
                                ElevatedButton(
                                    onPressed: () async {
                                        String username = _usernameController.text;
                                        String password = _passwordController.text;

                                        // URL LOGIN YANG BENAR: Menggunakan backendBase dari config.dart
                                        final loginUrl = '$backendBase/auth/login/';

                                        final response = await request.login(loginUrl, {
                                            'username': username,
                                            'password': password,
                                        });

                                        if (request.loggedIn) {
                                            String message = response['message'] ?? 'Login successful.';
                                            String uname = response['username'] ?? 'user';
                                            if (context.mounted) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MyHomePage()),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    ..hideCurrentSnackBar()
                                                    ..showSnackBar(
                                                        SnackBar(
                                                            content: Text("$message Welcome, $uname.")),
                                                    );
                                            }
                                        } else {
                                            if (context.mounted) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(
                                                        title: const Text('Login Failed'),
                                                        content: Text(response['message'] ?? "Please check your credentials."),
                                                        actions: [
                                                            TextButton(
                                                                child: const Text('OK'),
                                                                onPressed: () {
                                                                    Navigator.pop(context);
                                                                },
                                                            ),
                                                        ],
                                                    ),
                                                );
                                            }
                                        }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(double.infinity, 50),
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    ),
                                    child: const Text('Login'),
                                ),
                                const SizedBox(height: 36.0),
                                GestureDetector(
                                    onTap: () {
                                        Navigator.pushNamed(context, '/register');
                                    },
                                    child: Text(
                                        'Don\'t have an account? Register',
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: 16.0,
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        ),
    );
  }
}