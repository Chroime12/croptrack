import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    required this.label,
    required this.textController,
    required this.icon,
    this.keyboardType,
    this.validator, // Add this parameter for validation
    super.key,
  });

  final String label;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final IconData icon;
  final String? Function(String?)? validator;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  // Boolean to track whether the password is visible or not
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      controller: widget.textController,
      keyboardType: widget.keyboardType,
      obscureText: widget.label.toLowerCase() == 'password' ||
              widget.label.toLowerCase() == 'confirm password'
          ? _obscureText
          : false, // Only obscure password
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        counterText: '',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Icon(
            widget.icon,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            size: 24.0, // Adjust icon size
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        suffixIcon: widget.label.toLowerCase() == 'password' ||
                widget.label.toLowerCase() == 'confirm password'
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }
}
