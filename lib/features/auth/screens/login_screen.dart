import 'package:croptrack/features/auth/providers/login_provider.dart';
import 'package:croptrack/features/auth/screens/register_screen.dart';
import 'package:croptrack/features/auth/widgets/sign_in_button.dart';
import 'package:croptrack/features/auth/widgets/text_input.dart';
import 'package:croptrack/utils/slide_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final form = GlobalKey<FormState>();

    final loginState = ref.watch(loginProvider);

    Future<void> submit() async {
      final isValid = form.currentState!.validate();

      if (!isValid) {
        return;
      }

      form.currentState!.save();

      final loginNotifier = ref.read(loginProvider.notifier);
      await loginNotifier.loginUser(
          email: emailController.text, password: passwordController.text);
    }

    loginState.when(
      data: (_) => {},
      loading: () => {},
      error: (error, stackTrace) {},
    );

    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    double logoHeight = keyboardVisible ? 160.0 : 240.0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            _buildLogo(logoHeight),
            _buildLoginForm(context, form, emailController, passwordController,
                submit, loginState),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(double logoHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: logoHeight,
        child: Image.asset(
          'assets/logo/LIGHT HORIZONTAL.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildLoginForm(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController,
      Future<void> Function() submit,
      AsyncValue loginState) {
    return Expanded(
      flex: 2,
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
                _buildEmailField(emailController),
                const SizedBox(height: 16.0),
                _buildPasswordField(passwordController),
                _buildForgotPasswordButton(context),
                const SizedBox(height: 10.0),
                SignInButton(
                    onPressed: submit, isLoading: loginState.isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(TextEditingController emailController) {
    return TextInput(
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
    );
  }

  Widget _buildPasswordField(TextEditingController passwordController) {
    return TextInput(
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
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            // Handle forgot password logic here
          },
          child: Text(
            'Forgot Password?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
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
              _buildGoogleSignInButton(context),
              const SizedBox(height: 20.0),
              _buildRegisterButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New to CropTrack?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(slideLeftTransition(const RegisterScreen()));
          },
          child: Text(
            'Register',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
