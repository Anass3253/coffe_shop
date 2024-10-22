import 'package:app/widgets/custom_btn.dart';
import 'package:app/widgets/customtxt_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final formState = GlobalKey<FormState>();
  bool _isPass = true;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void _onLogin() async {
    final isValid = formState.currentState!.validate();
    if (!isValid) {
      print('Not Valid');
      return;
    }
    formState.currentState!.save();
    try {
      final credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      if (credentials.user!.emailVerified) {
        Navigator.of(context).pushReplacementNamed("Homepage");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Welcome Back!"),
          ),
        );
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Verification Alert',
          desc:
              'A verification mail has been sent to you, Please verify to login!',
        ).show();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No user found for that email."),
          ),
        );

        //print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );

        //print('Wrong password provided for that user.');
      } else {
        print(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Form(
        key: formState,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 10),
                      child: Image.asset(
                        'images/logo.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Login to continue using the app',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomTxtField(
                    txtHint: "Enter email here...",
                    txtController: _email,
                    keyboardType: TextInputType.emailAddress,
                    isPass: false,
                    validator: (val) {
                      if (val == "") {
                        return "Invalid Empty Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Password',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Stack(
                    children: [
                      CustomTxtField(
                        txtHint: "Enter Password here...",
                        txtController: _password,
                        keyboardType: TextInputType.visiblePassword,
                        isPass: _isPass,
                        validator: (val) {
                          if (val == "") {
                            return "Invalid Empty Field";
                          }
                          return null;
                        },
                      ),
                      Positioned(
                        right: double.minPositive,
                        bottom: double.minPositive,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPass = !_isPass;
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomBtn(
                btnLabel: "Login",
                onPressed: _onLogin,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomBtn(
                btnLabel: "Login with Google",
                onPressed: () {},
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('signUp');
                },
                child: const Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Doesn\'t have an account? '),
                        TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                color: Color.fromARGB(255, 96, 43, 24)))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
