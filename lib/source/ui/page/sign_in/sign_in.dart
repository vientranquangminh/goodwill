// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/routes.dart';

import '../../../service/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isDoctor = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200.0,
                  height: 200.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.images.signIn.zyroImage.path),
                        fit: BoxFit.cover),
                  ),
                ),
                const Text("Login to Your Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 44.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your email address';
                  //   } else if (!EmailValidator.validate(value)) {
                  //     return 'Please enter a valid email address';
                  //   }
                  //   return null;
                  // },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      hintText: "Email",
                      prefixIcon: const Icon(
                        color: Colors.black,
                        Icons.email,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your password';
                  //   } else if (value.length < 8) {
                  //     return "Length of password's characters must be 8 or greater";
                  //   }
                  //   return null;
                  // },
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: Colors.black,
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        color: Colors.black,
                        Icons.lock,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(height: 12.0),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    fillColor: Colors.black,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Sign in
                        String email = _emailController.text;
                        String password = _passwordController.text;

                        var userCredential =
                            await AuthService.signInWithEmailAndPassword(
                                email, password);
                        if (userCredential == null) return;
                        Navigator.pushNamed(context, Routes.myPageController);
                      }
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signUp);
                  },
                  child: const Text('Sign up'),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Forgot the password?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
