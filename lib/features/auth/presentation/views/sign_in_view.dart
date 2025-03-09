import 'package:flutter/material.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/utils/assets/assets.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Text(
                //   "Welcome Back!",
                //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    AssetsData.logo,
                    fit: BoxFit.fitHeight,
                    // width: 50,
                  ),
                ),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutesNames.companiesView);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Sign In", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 5),
                // OutlinedButton.icon(
                //   onPressed: () {
                //     // Handle Google sign-in
                //   },
                //   style: OutlinedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 15),
                //     side: const BorderSide(color: Colors.grey),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   icon: Icon(MdiIcons.google),
                //   label: const Text(
                //     "Sign in with Google",
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //   ),
                // ),
                // const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutesNames.signUpView);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
