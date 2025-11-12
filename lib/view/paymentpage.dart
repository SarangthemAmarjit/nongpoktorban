// // Payment Page - Web Optimized
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:torbanticketing/view/recieptpage.dart';

// import '../main.dart';

// class PaymentPage extends StatefulWidget {
//   final String name;
//   final String mobile;
//   final String address;
//   final String gender;
//   final DateTime visitDate;
//   final int adults;
//   final int children;

//   const PaymentPage({
//     Key? key,
//     required this.name,
//     required this.mobile,
//     required this.address,
//     required this.gender,
//     required this.visitDate,
//     required this.adults,
//     required this.children,
//   }) : super(key: key);

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   String? _paymentMethod;

//   double _calculateTotal() {
//     return (widget.adults * adultPrice) + (widget.children * childPrice);
//   }

//   void _completePayment() {
//     if (_paymentMethod == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Please select a payment method'),
//           backgroundColor: Colors.orange,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//       return;
//     }

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ReceiptPage(
//           name: widget.name,
//           mobile: widget.mobile,
//           address: widget.address,

//           adults: widget.adults,
//           children: widget.children,
//           total: _calculateTotal(),
//           paymentMethod: _paymentMethod!,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isLargeScreen = size.width > 800;

//     return ResponsiveCenter(
//       maxWidth: isLargeScreen ? 1000 : double.infinity,
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(isLargeScreen ? 32.0 : 16.0),
//         child: isLargeScreen ? _buildLargeScreenLayout() : _buildMobileLayout(),
//       ),
//     );
//   }

//   Widget _buildLargeScreenLayout() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(flex: 5, child: _buildSummaryCard(true)),
//         const SizedBox(width: 32),
//         Expanded(flex: 5, child: _buildPaymentCard(true)),
//       ],
//     );
//   }

//   Widget _buildMobileLayout() {
//     return Column(
//       children: [
//         _buildSummaryCard(false),
//         const SizedBox(height: 16),
//         _buildPaymentCard(false),
//       ],
//     );
//   }

//   Widget _buildSummaryCard(bool isLarge) {
//     return Card(
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       child: Padding(
//         padding: EdgeInsets.all(isLarge ? 32.0 : 24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: isLarge ? 56 : 48,
//                   height: isLarge ? 56 : 48,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF9C27B0),
//                     borderRadius: BorderRadius.circular(28),
//                   ),
//                   child: Icon(
//                     Icons.receipt_long,
//                     color: Colors.white,
//                     size: isLarge ? 28 : 24,
//                   ),
//                 ),
//                 SizedBox(width: isLarge ? 20 : 16),
//                 Text(
//                   'Booking Summary',
//                   style: TextStyle(
//                     fontSize: isLarge ? 26 : 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: isLarge ? 32 : 24),
//             Container(
//               padding: EdgeInsets.all(isLarge ? 24 : 20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFFF3E5F5), Color(0xFFFFEBEE)],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   _buildSummaryRow('Name:', widget.name, isLarge),
//                   _buildSummaryRow('Mobile:', widget.mobile, isLarge),
//                   _buildSummaryRow('Gender:', widget.gender, isLarge),
//                   _buildSummaryRow(
//                     'Visit Date:',
//                     DateFormat('dd MMM yyyy').format(widget.visitDate),
//                     isLarge,
//                   ),
//                   const Divider(height: 32, thickness: 2),
//                   _buildSummaryRow(
//                     'Adults × ${widget.adults}:',
//                     '₹${(widget.adults * adultPrice).toStringAsFixed(0)}',
//                     isLarge,
//                   ),
//                   _buildSummaryRow(
//                     'Children × ${widget.children}:',
//                     '₹${(widget.children * childPrice).toStringAsFixed(0)}',
//                     isLarge,
//                   ),
//                   const Divider(height: 32, thickness: 2),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Total:',
//                         style: TextStyle(
//                           fontSize: isLarge ? 24 : 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         '₹${_calculateTotal().toStringAsFixed(0)}',
//                         style: TextStyle(
//                           fontSize: isLarge ? 32 : 28,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF9C27B0),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentCard(bool isLarge) {
//     return Card(
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       child: Padding(
//         padding: EdgeInsets.all(isLarge ? 32.0 : 24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: isLarge ? 56 : 48,
//                   height: isLarge ? 56 : 48,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF9C27B0),
//                     borderRadius: BorderRadius.circular(28),
//                   ),
//                   child: Icon(
//                     Icons.credit_card,
//                     color: Colors.white,
//                     size: isLarge ? 28 : 24,
//                   ),
//                 ),
//                 SizedBox(width: isLarge ? 20 : 16),
//                 Text(
//                   'Payment Method',
//                   style: TextStyle(
//                     fontSize: isLarge ? 26 : 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: isLarge ? 32 : 24),
//             _buildPaymentOption(
//               'Credit/Debit Card',
//               Icons.credit_card,
//               isLarge,
//             ),
//             const SizedBox(height: 16),
//             _buildPaymentOption('UPI', Icons.payment, isLarge),
//             const SizedBox(height: 16),
//             _buildPaymentOption('Net Banking', Icons.account_balance, isLarge),
//             const SizedBox(height: 16),
//             _buildPaymentOption('Cash (At Counter)', Icons.money, isLarge),
//             SizedBox(height: isLarge ? 32 : 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(
//                         vertical: isLarge ? 20 : 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       side: const BorderSide(
//                         color: Color(0xFF757575),
//                         width: 2,
//                       ),
//                     ),
//                     child: Text(
//                       'Back',
//                       style: TextStyle(fontSize: isLarge ? 18 : 16),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: isLarge ? 24 : 16),
//                 Expanded(
//                   flex: 2,
//                   child: ElevatedButton(
//                     onPressed: _completePayment,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF9C27B0),
//                       padding: EdgeInsets.symmetric(
//                         vertical: isLarge ? 20 : 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 4,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Complete Payment',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: isLarge ? 18 : 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         const Icon(Icons.check_circle, color: Colors.white),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, String value, bool isLarge) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: isLarge ? 16 : 14,
//               color: Colors.grey[700],
//             ),
//           ),
//           const SizedBox(width: 16),
//           Flexible(
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: TextStyle(
//                 fontSize: isLarge ? 16 : 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentOption(String title, IconData icon, bool isLarge) {
//     final isSelected = _paymentMethod == title;
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _paymentMethod = title;
//         });
//       },
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: EdgeInsets.all(isLarge ? 20 : 16),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? const Color(0xFF9C27B0).withOpacity(0.1)
//               : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? const Color(0xFF9C27B0) : Colors.grey[300]!,
//             width: isSelected ? 3 : 2,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: isSelected ? const Color(0xFF9C27B0) : Colors.grey[600],
//               size: isLarge ? 28 : 24,
//             ),
//             SizedBox(width: isLarge ? 20 : 16),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: isLarge ? 18 : 16,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                   color: isSelected ? const Color(0xFF9C27B0) : Colors.black87,
//                 ),
//               ),
//             ),
//             if (isSelected)
//               const Icon(
//                 Icons.check_circle,
//                 color: Color(0xFF9C27B0),
//                 size: 28,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
