import 'package:flutter/material.dart';
import 'package:quizz_app/layout.dart';
import 'package:quizz_app/screens/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;  // 👁️ Controls password visibility
  bool _isConfirmPasswordVisible = false;  // 👁️ Controls confirm password visibility

  void _validateAndRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account Created Successfully!", style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Layout()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [theme.colorScheme.surfaceVariant, theme.colorScheme.background]
                : [theme.colorScheme.onSecondary, theme.colorScheme.inversePrimary, theme.colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Account",
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🧑‍💼 Name Field
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        filled: true,
                        fillColor: theme.colorScheme.surface.withOpacity(0.9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Name is required!" : null,
                    ),
                    const SizedBox(height: 12),

                    // 📧 Email Field
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: theme.colorScheme.surface.withOpacity(0.9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Email is required!";
                        if (!RegExp(r"^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+").hasMatch(value)) {
                          return "Enter a valid email!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // 🔒 Password Field with Visibility Toggle
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: theme.colorScheme.surface.withOpacity(0.9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Password is required!";
                        if (value.length < 6) return "Password must be at least 6 characters!";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // 🔑 Confirm Password Field with Visibility Toggle
                    TextFormField(
                      controller: _confirmPasswordController,
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        filled: true,
                        fillColor: theme.colorScheme.surface.withOpacity(0.9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                          icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible; // Toggle confirm password visibility
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Confirm your password!";
                        if (value != _passwordController.text) return "Passwords do not match!";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // ✅ Register Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Layout()));

                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Register", style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 16)),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Login Navigation
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
