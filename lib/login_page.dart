import 'package:flutter/material.dart';
import 'admin_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username == 'admin' && password == 'admin123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminDashboard(onLogout: _logout)),
      );
    } else {
      setState(() {
        _error = 'Username atau password salah';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Admin Cafetaria Unpam',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.deepOrange.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.deepOrange.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Login', 
                style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
