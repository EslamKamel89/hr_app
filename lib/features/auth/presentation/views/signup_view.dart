import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/features/auth/controllers/params/register_params.dart';
import 'package:hr/features/auth/cubits/register/register_cubit.dart';
import 'package:hr/features/auth/models/user_model.dart';
import 'package:hr/utils/assets/assets.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, ApiResponseModel<UserModel?>>(
        listener: (context, state) {
          if (state.response == ResponseEnum.success) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutesNames.companiesView,
              (_) => false,
            );
          }
        },
        builder: (context, state) {
          final controller = context.read<RegisterCubit>();
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
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset(
                              AssetsData.logo,
                              fit: BoxFit.fitHeight,
                              // width: 50,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Sign up to get started",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          AuthTextFormField(
                            labelText: "Full Name",
                            prefixIcon: Icons.person_outline,
                            controller: _nameController,
                            validator:
                                (input) => valdiator(
                                  input: input,
                                  label: 'Full Name',
                                  isRequired: true,
                                  minChars: 5,
                                  maxChars: 50,
                                ),
                          ),
                          const SizedBox(height: 20),
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
                                  minChars: 5,
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
                                  minChars: 5,
                                  maxChars: 50,
                                ),
                          ),
                          const SizedBox(height: 20),
                          AuthTextFormField(
                            obscureText: true,
                            labelText: "Confirm Password",
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordConfirmController,
                            validator: (input) {
                              return valdiator(
                                input: input,
                                label: 'Confirm Password',
                                isRequired: true,
                                minChars: 5,
                                maxChars: 50,
                                isConfirmPassword: true,
                                firstPassword: _passwordController.text,
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          state.response == ResponseEnum.loading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    controller.register(
                                      params: RegisterParams(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        levelId: 1,
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
                                  "Sign Up",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Sign In",
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
