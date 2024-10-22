import 'package:app/widgets/custom_btn.dart';
import 'package:app/widgets/customtxt_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _userName.dispose();
  }

  void _isSignUp() async {
    if (formState.currentState!.validate()) {
      try {
        final credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Verification Alert',
          desc:
              'A verification mail has been sent to you, Please verify to login!',
          btnOkOnPress: () {
            Navigator.of(context).pushReplacementNamed("Login");
          },
        ).show();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The password provided is too weak."),
              duration: Durations.extralong4,
            ),
          );
          //print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The account already exists for that email."),
              duration: Durations.extralong4,
            ),
          );
          //print('The account already exists for that email.');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.code),
              duration: Durations.extralong4,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
        print(e);
      }
    } else {
      print('Not Valid');
    }
  }

  bool _isPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
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
                    'SignUp',
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
                    'SignUp to continue using the app',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Username',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomTxtField(
                    txtHint: "Enter username here...",
                    txtController: _userName,
                    keyboardType: TextInputType.name,
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
                    'Email',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
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
            ),
            const SizedBox(
              height: 10,
            ),
            CustomBtn(
              btnLabel: "SignUp",
              onPressed: _isSignUp,
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('Login');
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Has an account? '),
                      TextSpan(
                          text: 'Login',
                          style:
                              TextStyle(color: Color.fromARGB(255, 96, 43, 24)))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
