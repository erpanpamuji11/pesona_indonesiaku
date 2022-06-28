import 'package:authentication/presentation/pages/signup_page.dart';
import 'package:core/presentation/pages/ParentPage.dart';
import 'package:core/widgets/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.pushNamed(context, ParentPage.ROUTE_NAME);
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }

    // navigator lodaing belum bekerja
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/app.png',
                  width: 250,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Selamat Datang Kembali",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 30,
                ),
                //email textfiled
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: buildTextField(_emailController, 'Email', 'Masukan Email', TextInputType.emailAddress),
                ),
                const SizedBox(
                  height: 20,
                ),
                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: buildTextFieldPassword(_passwordController, 'Password', 'Masukan Password', TextInputType.visiblePassword),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: InkWell(
                      onTap: signIn,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum Punya Akun?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SignUpPage.routeName),
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
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

  Widget buildTextFieldPassword(TextEditingController controller, String labelText, String hintText, TextInputType inputType) {
    return TextFormField(
      controller: controller,
      obscureText: _obscureText,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.black, fontSize: 17),
      validator: (value) {
        if (value!.isEmpty) {
          return "it is empty";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18),
        labelStyle: const TextStyle(color: Colors.grey),
        // prefix: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: _obscureText == true
            ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = false;
              });
            },
            icon: const Icon(
              Icons.remove_red_eye,
              size: 20,
            ))
            : IconButton(
            onPressed: () {
              setState(() {
                _obscureText = true;
              });
            },
            icon: const Icon(
              Icons.visibility_off,
              size: 20,
            )),),

    );
  }
}
