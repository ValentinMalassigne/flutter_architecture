import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/commons/widgets/custom_button.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key, required this.message, required this.callback});
  final String message;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          const SizedBox(height: 20.0),
          CustomButton(title: "Retry", onTap: callback)
        ],
      ),
    );
  }
}
