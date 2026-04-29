import 'package:ecommerce_app_api_26/features/auth/data/auth_api/api_helper.dart';
import 'package:ecommerce_app_api_26/features/auth/data/auth_api/auth_api.dart';
import 'package:ecommerce_app_api_26/features/auth/models/token_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_api_26/features/auth/presentation/screens/signup_screen.dart';
import 'package:ecommerce_app_api_26/features/main_wrapper/presentation/screens/main_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isloading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      try {
        TokenModel data = await AuthApi().login(
          _emailController.text,
          _passwordController.text,
        );
        if (data.accessToken != null) {
          await ApiHelper.saveAccessToken(data.accessToken!);
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Logged Successfully")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainWrapper()),
        );
      } catch (e) {
        String? savedEmail = await ApiHelper.getEmail();
        String? savedPassword = await ApiHelper.getPassword();
        if (_emailController.text == savedEmail &&
            _passwordController.text == savedPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Logged Successfully (Local User)")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainWrapper()),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString()..replaceAll("Exception: ", ""))));
        }
      }
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.blue],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isloading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isloading
                              ? CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Don\'t have an account? Sign Up',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
