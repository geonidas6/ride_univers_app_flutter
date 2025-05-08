import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

enum NotificationType { success, error, warning, info }

class NotificationService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required NotificationType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color getColor() {
      switch (type) {
        case NotificationType.success:
          return Colors.green;
        case NotificationType.error:
          return Colors.red;
        case NotificationType.warning:
          return Colors.orange;
        case NotificationType.info:
          return Colors.blue;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: getColor(),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static void _showDialog({
    required String title,
    required String message,
    required NotificationType type,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Color getColor() {
      switch (type) {
        case NotificationType.success:
          return Colors.green;
        case NotificationType.error:
          return Colors.red;
        case NotificationType.warning:
          return Colors.orange;
        case NotificationType.info:
          return Colors.blue;
      }
    }

    IconData getIcon() {
      switch (type) {
        case NotificationType.success:
          return Icons.check_circle;
        case NotificationType.error:
          return Icons.error;
        case NotificationType.warning:
          return Icons.warning;
        case NotificationType.info:
          return Icons.info;
      }
    }

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: getColor().withOpacity(0.1),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Icon(getIcon(), color: getColor(), size: 50),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: getColor(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (onConfirm != null || onCancel != null)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (onCancel != null)
                      TextButton(
                        onPressed: onCancel,
                        child: const Text('Annuler'),
                      ),
                    if (onConfirm != null)
                      TextButton(
                        onPressed: onConfirm,
                        child: const Text('Confirmer'),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  static void showSuccess(
    String message, {
    String title = 'Succès',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    _showDialog(
      title: title,
      message: message,
      type: NotificationType.success,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static void showError(
    String message, {
    String title = 'Erreur',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    _showDialog(
      title: title,
      message: message,
      type: NotificationType.error,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static void showWarning(
    String message, {
    String title = 'Attention',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    _showDialog(
      title: title,
      message: message,
      type: NotificationType.warning,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static void showInfo(
    String message, {
    String title = 'Information',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    _showDialog(
      title: title,
      message: message,
      type: NotificationType.info,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static Future<bool> showConfirmation({
    required String message,
    String title = 'Confirmation',
    String confirmText = 'Confirmer',
    String cancelText = 'Annuler',
  }) async {
    final completer = Completer<bool>();

    _showDialog(
      title: title,
      message: message,
      type: NotificationType.warning,
      onConfirm: () => completer.complete(true),
      onCancel: () => completer.complete(false),
    );

    return completer.future;
  }
}
