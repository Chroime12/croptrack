import 'package:croptrack/features/auth/providers/register_provider.dart';
import 'package:croptrack/features/auth/widgets/sign_up_button.dart';
import 'package:croptrack/features/auth/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    final form = GlobalKey<FormState>();

    final registerState = ref.watch(registerProvider);

    Future<void> _submit() async {
      final isValid = form.currentState!.validate();
      if (!isValid) {
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      form.currentState!.save();

      final registerNotifier = ref.read(registerProvider.notifier);
      await registerNotifier.registerUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
      );
    }

    registerState.when(
      data: (_) => {},
      loading: () => {},
      error: (error, stackTrace) {},
    );

    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    double logoHeight = keyboardVisible ? 80.0 : 150.0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(logoHeight),
            _buildRegisterForm(
                context,
                form,
                usernameController,
                emailController,
                passwordController,
                confirmPasswordController,
                registerState,
                _submit),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(double logoHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      child: Image.asset(
        'assets/logo/LIGHT HORIZONTAL.png',
        fit: BoxFit.contain,
        height: logoHeight,
      ),
    );
  }

  Widget _buildRegisterForm(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController usernameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController,
      AsyncValue registerState,
      Future<void> Function() submit) {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInput(
                  label: "Username",
                  textController: usernameController,
                  icon: Icons.person_outline,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.length < 2) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextInput(
                  label: "Email",
                  textController: emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextInput(
                  label: "Password",
                  textController: passwordController,
                  icon: Icons.password_outlined,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextInput(
                  label: "Confirm Password",
                  textController: confirmPasswordController,
                  icon: Icons.password_outlined,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                SignUpButton(
                    onPressed: submit, isLoading: registerState.isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/google.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Continue with Google',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
