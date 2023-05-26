import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_toast/app_toast.dart';
import 'package:goodwill/source/common/widgets/snack_bar/snack_bar.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassWordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassWordController.dispose();
  }

  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                Text(context.localizations.createNewAccount,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold)),
                const SizedBox(height: 44.0),
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
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      hintText: context.localizations.userEmail,
                      prefixIcon: const Icon(
                        color: Colors.black,
                        Icons.email,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      hintText: context.localizations.password,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.localizations.plsePass;
                    } else if (value.length < 8) {
                      return context.localizations.plseLengthPass;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _confirmPassWordController,
                  obscureText: _confirmPasswordVisible,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      hintText: context.localizations.confirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: Colors.black,
                          _confirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        color: Colors.black,
                        Icons.lock,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.localizations.confirmPassword;
                    } else if (value != _passwordController.text) {
                      return context.localizations.passwordNotMatch;
                    }
                    return null;
                  },
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
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        bool isOk = false;
                        try {
                          await AuthService.signUp(email, password, context);
                          isOk = true;
                        } catch (signUpError) {
                          if (signUpError is PlatformException) {
                            if (signUpError.code ==
                                'ERROR_EMAIL_ALREADY_IN_USE') {
                              AppToasts.showToast(
                                  context: context, title: 'error');
                            }
                          }
                        }
                        FirebaseAuth.instance.currentUser != null
                            // ignore: use_build_context_synchronously
                            ? context.pushReplacementNamed(Routes.waitScreen)
                            // ignore: use_build_context_synchronously
                            : AppToasts.showErrorToast(
                                context: context,
                                title: context.localizations.emailused);
                      } else {
                        showSnackBar(context.localizations.error,
                            context.localizations.emailused);
                      }
                    },
                    child: Text(
                      context.localizations.signUp,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.localizations.alreadyAccount,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.signIn);
                      },
                      child: Text(
                        context.localizations.signIn,
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
