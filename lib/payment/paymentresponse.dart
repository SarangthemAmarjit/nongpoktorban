import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torbanticketing/controller/pagecon.dart';

class PaymentResponsePage extends StatelessWidget {
  final PaymentStatus status;

  const PaymentResponsePage({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade50, Colors.grey.shade100],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildStatusCard(context, config)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, StatusConfig config) {
    Pagemanagementcontroller pngcon = Get.find<Pagemanagementcontroller>();
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: config.bgColor,
        border: Border.all(color: config.borderColor, width: 2),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(config.icon, size: 80, color: config.color),
          const SizedBox(height: 24),
          Text(
            config.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            config.message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            config.subMessage,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              pngcon.resetPage();
              Get.offAllNamed('/');
            },
            icon: const Icon(Icons.home, size: 20),
            label: const Text(
              'Return to Home',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade900,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Need help? ',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to support page
            Navigator.pushNamed(context, '/support');
          },
          child: const Text(
            'Contact Support',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  StatusConfig _getStatusConfig(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.failed:
        return StatusConfig(
          icon: Icons.cancel,
          color: Colors.red.shade500,
          bgColor: Colors.red.shade50,
          borderColor: Colors.red.shade200,
          title: 'Payment Failed',
          message:
              'We couldn\'t process your payment. Please check your payment details and try again.',
          subMessage:
              'If the problem persists, please contact your bank or try a different payment method.',
        );
      case PaymentStatus.cancelled:
        return StatusConfig(
          icon: Icons.error_outline,
          color: Colors.orange.shade500,
          bgColor: Colors.orange.shade50,
          borderColor: Colors.orange.shade200,
          title: 'Payment Cancelled',
          message:
              'Your payment has been cancelled. No charges were made to your account.',
          subMessage:
              'You can return to the homepage or try completing your purchase again.',
        );
    }
  }
}

enum PaymentStatus { failed, cancelled }

class StatusConfig {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final Color borderColor;
  final String title;
  final String message;
  final String subMessage;

  StatusConfig({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.borderColor,
    required this.title,
    required this.message,
    required this.subMessage,
  });
}

// Example usage in your app:
// 
// For failed payment:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => const PaymentResponsePage(
//       status: PaymentStatus.failed,
//     ),
//   ),
// );
//
// For cancelled payment:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => const PaymentResponsePage(
//       status: PaymentStatus.cancelled,
//     ),
//   ),
// );