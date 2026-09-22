import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),

            child: Column(
              children: [
                const SizedBox(height: 55),

                // LOGO
                Image.asset(
                  'assets/images/smile.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 25),

                // WELCOME BACK
                const Text(
                  'Welcome back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 50),

                // EMAIL
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),

                    decoration: InputDecoration(
                      hintText: 'Email',

                      hintStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 21,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.1,
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.1,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // PASSWORD
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: TextField(
                    controller: passwordController,

                    obscureText: !showPassword,

                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),

                    decoration: InputDecoration(
                      hintText: 'Password',

                      hintStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 21,
                      ),

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },

                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 27,
                          color: const Color(0xFF9AA0A6),
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.1,
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.1,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // FORGOT PASSWORD
                Align(
                  alignment: Alignment.centerRight,

                  child: TextButton(
                    onPressed: () {},

                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),

                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 75,

                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0098FF),

                      foregroundColor: Colors.white,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),

                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 42),

                // OR
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.black.withOpacity(0.21),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 11),

                      child: Text(
                        'or',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.black.withOpacity(0.21),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // SOCIAL LOGIN
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    socialButton(
                      Image.asset('assets/icons/Frame.png',
                        width: 32,
                        height: 32,
                      ),
                    ),

                    const SizedBox(width: 25),

                    socialButton(
                      Image.asset(
                        'assets/icons/Social_Icons.png',
                        width: 32,
                        height: 32,
                      ),
                    ),

                    const SizedBox(width: 25),

                    socialButton(
                      const Icon(
                        Icons.apple,
                        size: 32,
                        color: Color(0xFF30343B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(Widget child) {
    return SizedBox(
      width: 64,
      height: 64,

      child: OutlinedButton(
        onPressed: () {},

        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,

          side: const BorderSide(color: Colors.black, width: 1.6),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),

        child: child,
      ),
    );
  }
}
