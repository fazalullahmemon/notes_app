import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:notes_app/common_imports.dart';
import 'package:notes_app/widgets/custom_elevated_button.dart';

class FrequentFunctions {
  FrequentFunctions._();
  static showErrorDialog(String message, BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            CustomElevatedButton(
              width: 100,
              onTap: () => Navigator.of(context).pop(), // Confirm
              text: "Close",
            ),
          ],
        ),
      );
  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
