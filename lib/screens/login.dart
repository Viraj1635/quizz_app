import 'package:flutter/material.dart';
import 'package:quizz_app/screens/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      // If validation is successful, navigate to the next screen (replace with actual logic)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logging in...", style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );

      // Simulate login and navigate (replace with actual authentication logic)
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
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
                ? [theme.colorScheme.surfaceVariant, theme.colorScheme.background] // Dark mode
                : [theme.colorScheme.primary, theme.colorScheme.inversePrimary, theme.colorScheme.onSecondary], // Light mode
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome Back!",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 📧 Email TextField with Validation
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Ensure text color is visible
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: isDarkMode ? Colors.white60 : Colors.black54), // Adjust hint color for contrast
                      filled: true,
                      fillColor: isDarkMode
                          ? theme.colorScheme.surface.withOpacity(0.8) // Dark mode fill
                          : theme.colorScheme.surface.withOpacity(0.9), // Light mode fill
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required!";
                      } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return "Enter a valid email!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // 🔒 Password TextField with Validation
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Ensure text color is visible
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: isDarkMode ? Colors.white60 : Colors.black54), // Adjust hint color for contrast
                      filled: true,
                      fillColor: isDarkMode
                          ? theme.colorScheme.surface.withOpacity(0.8) // Dark mode fill
                          : theme.colorScheme.surface.withOpacity(0.9), // Light mode fill
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required!";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // 🔑 Login Button with Validation Check
                  ElevatedButton(
                    onPressed: _validateAndLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Login", style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 16)),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Register Navigation
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: theme.colorScheme.onSurface),
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
