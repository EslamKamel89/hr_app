import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/features/auth/controllers/params/login_params.dart';
import 'package:hr/features/auth/cubits/login_cubit.dart';
import 'package:hr/features/auth/models/user_model.dart';
import 'package:hr/utils/assets/assets.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, ApiResponseModel<UserModel?>>(
        listener: (context, state) {
          if (state.response == ResponseEnum.success) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutesNames.companiesView,
              (_) => false,
            );
          }
        },
        builder: (context, state) {
          final controller = context.read<LoginCubit>();
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: _formKey,
                child: Center(
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
                          AuthTextFormField(
                            labelText: "Email Address",
                            prefixIcon: Icons.email_outlined,
                            controller: _emailController,
                            validator:
                                (input) => valdiator(
                                  input: input,
                                  label: 'Email',
                                  isRequired: true,
                                  isEmail: true,
                                  minChars: 6,
                                  maxChars: 50,
                                ),
                          ),
                          const SizedBox(height: 20),
                          AuthTextFormField(
                            obscureText: true,
                            labelText: "Password",
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordController,
                            validator:
                                (input) => valdiator(
                                  input: input,
                                  label: 'Password',
                                  isRequired: true,
                                  minChars: 6,
                                  maxChars: 50,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          state.response == ResponseEnum.loading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    controller.login(
                                      params: LoginParams(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Expanded(child: Divider(thickness: 1)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "OR",
                                  style: TextStyle(color: Colors.grey),
                                ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
