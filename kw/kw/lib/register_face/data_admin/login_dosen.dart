import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kw/register_face/data_admin/data2.dart';

class LoginDosen extends StatefulWidget {
  const LoginDosen({super.key});

  @override
  _LoginDosenState createState() => _LoginDosenState();
}

class _LoginDosenState extends State<LoginDosen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Add this line

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User signed in: ${userCredential.user?.email}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserListWidget2()),
      );
    } catch (e) {
      print('Failed to sign in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 12, 199, 246),
                  Color.fromARGB(255, 1, 31, 38)
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Positioned(
                        top: 100,
                        left: 45,
                        child: Container(
                          height: 300,
                          width: 300,
                          child: Image.asset(
                            'assets/desain.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        'Akun ini hanya diperuntukan untuk dosen',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_isPasswordVisible, // Modify this line
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: _signIn,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 56, 122, 222),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(147, 255, 255, 255),
                                spreadRadius: 0.4,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 30,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ))),
        ],
      ),
    );
  }
}
