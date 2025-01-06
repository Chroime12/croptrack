import 'package:flutter/material.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({super.key, required this.onPressed});

  final Future<void> Function() onPressed;

  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  bool _isLoading = false;

  void _handlePress() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: _isLoading ? null : _handlePress,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (_isLoading)
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 2,
                ),
              )
            else
              Icon(
                Icons.login,
                color: Theme.of(context).colorScheme.primary,
              ),
            const SizedBox(width: 10),
            Text(
              _isLoading ? 'Signing up' : 'Sign up',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
