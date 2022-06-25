import 'package:authentication/presentation/pages/signup_page.dart';
import 'package:core/presentation/pages/ParentPage.dart';
import 'package:core/presentation/pages/home_page.dart';
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

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
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
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/app.png',
                  width: 250,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Selamat Datang Kembali",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                //email textfiled
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Email',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //password textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: InkWell(
                      onTap: signIn,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
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
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kamu Belum Daftar?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SignUpPage.routeName),
                      child: Text(
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
}
