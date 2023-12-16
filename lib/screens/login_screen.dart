import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../services/auth_services.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAPIcallProcess = false;
  bool hidePassword = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;

  final AuthService authService =
      AuthService(baseUrl: 'https://products-9q0g.onrender.com');
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<dynamic> login() async {
    setState(() {
      isLoading = true;
    });

    final String username = usernameController.text;
    final String password = passwordController.text;

    final Map<String, dynamic> result =
        await authService.login(username, password);

    setState(() {
      isLoading = true;
    });

    if (result.containsKey('error')) {
      print('Login error: ${result['error']}');
    } else {
      print('Login successful');
      print('User Profile: ${result['username']}, ${result['email']}');

      if (context.mounted) {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor("#283B71"),
          body: ProgressHUD(
            inAsyncCall: isAPIcallProcess,
            key: UniqueKey(),
            child: Form(
              key: globalFormKey,
              child: _loginUI(context),
            ),
          )),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "images/ecommerce.png",
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "username",
            "Username",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "username can\t be empty.";
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
            },
            prefixIcon: const Icon(Icons.person),
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(.7),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context, "password", "Password",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "password can\t be empty.";
              }
              return null;
            }, (onSavedVal) {
              password = onSavedVal;
            },
                prefixIcon: const Icon(Icons.lock),
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(.7),
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white.withOpacity(.7),
                    icon: Icon(hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Forget Password ?',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer
                            ..onTap = () {
                              print('Forget password');
                            }),
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {},
              btnColor: HexColor("#283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
