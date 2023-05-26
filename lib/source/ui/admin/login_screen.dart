import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';

import 'admin_screen.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({Key? key}) : super(key: key);

  @override
  State<LoginAdminScreen> createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      body: Form(
        key: _formKey,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.grey[100],
              child: Column(
                children: [
                  Assets.svgs.mainIcon.svg(),
                  Text(
                    context.localizations.welcomeTo +
                        '\n' +
                        context.localizations.goodwill,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(context.localizations.loginAccount,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.localizations.email,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.localizations.plseAddEmail;
                            } else if (!EmailValidator.validate(value)) {
                              return context.localizations.plseValidEmail;
                            }
                            return null;
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: context.localizations.email,
                              prefixIcon: const Icon(
                                Icons.email,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(context.localizations.password,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.localizations.plsePass;
                            } else if (value.length < 8) {
                              return context.localizations.plseLengthPass;
                            }
                            return null;
                          },
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                              hintText: context.localizations.password,
                              suffixIcon: IconButton(
                                icon: Icon(
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
                                Icons.lock,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RawMaterialButton(
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            fillColor: const Color.fromARGB(255, 0, 0, 0),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AdminScreen(),
                                    ));
                              }
                            },
                            child: Text(
                              context.localizations.login,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
