// // Booking Page - Web Optimized
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:torbanticketing/main.dart';
// import 'package:torbanticketing/view/paymentpage.dart';

// class BookingPage extends StatefulWidget {
//   const BookingPage({Key? key}) : super(key: key);

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _addressController = TextEditingController();

//   String? _selectedGender;
//   DateTime? _selectedDate;
//   int _adults = 1;
//   int _children = 0;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   double _calculateTotal() {
//     return (_adults * adultPrice) + (_children * childPrice);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(primary: Color(0xFF2196F3)),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   void _proceedToPayment() {
//     if (_formKey.currentState!.validate() && _selectedDate != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PaymentPage(
//             name: _nameController.text,
//             mobile: _mobileController.text,
//             address: _addressController.text,
//             gender: _selectedGender!,
//             visitDate: _selectedDate!,
//             adults: _adults,
//             children: _children,
//           ),
//         ),
//       );
//     } else if (_selectedDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Please select visit date'),
//           backgroundColor: Colors.orange,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isLargeScreen = size.width > 800;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         title: const Text(
//           'Visitor Information',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xFF2196F3),
//         elevation: 0,
//         centerTitle: isLargeScreen,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: ResponsiveCenter(
//         maxWidth: isLargeScreen ? 900 : double.infinity,
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(isLargeScreen ? 32.0 : 16.0),
//           child: Card(
//             elevation: 8,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(isLargeScreen ? 48.0 : 24.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: isLargeScreen ? 64 : 48,
//                           height: isLargeScreen ? 64 : 48,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF2196F3),
//                             borderRadius: BorderRadius.circular(32),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.blue.withOpacity(0.3),
//                                 blurRadius: 10,
//                                 spreadRadius: 2,
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.person,
//                             color: Colors.white,
//                             size: isLargeScreen ? 32 : 24,
//                           ),
//                         ),
//                         SizedBox(width: isLargeScreen ? 24 : 16),
//                         Text(
//                           'Visitor Details',
//                           style: TextStyle(
//                             fontSize: isLargeScreen ? 32 : 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: isLargeScreen ? 40 : 24),

//                     // Two-column layout for large screens
//                     if (isLargeScreen)
//                       _buildLargeScreenForm()
//                     else
//                       _buildMobileForm(),

//                     SizedBox(height: isLargeScreen ? 32 : 24),

//                     // Ticket Category
//                     Text(
//                       'Ticket Category',
//                       style: TextStyle(
//                         fontSize: isLargeScreen ? 24 : 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: isLargeScreen ? 24 : 16),

//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildTicketCounter(
//                             'Adults',
//                             _adults,
//                             adultPrice,
//                             isLargeScreen,
//                             true,
//                           ),
//                         ),
//                         SizedBox(width: isLargeScreen ? 32 : 16),
//                         Expanded(
//                           child: _buildTicketCounter(
//                             'Children',
//                             _children,
//                             childPrice,
//                             isLargeScreen,
//                             false,
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: isLargeScreen ? 40 : 24),

//                     // Total Amount
//                     Container(
//                       padding: EdgeInsets.all(isLargeScreen ? 32 : 24),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFFE8F5E9), Color(0xFFE3F2FD)],
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: Colors.blue.withOpacity(0.3),
//                           width: 2,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total Amount:',
//                             style: TextStyle(
//                               fontSize: isLargeScreen ? 24 : 18,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           Text(
//                             '₹${_calculateTotal().toStringAsFixed(0)}',
//                             style: TextStyle(
//                               fontSize: isLargeScreen ? 36 : 28,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFF2196F3),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: isLargeScreen ? 40 : 24),

//                     // Buttons
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: isLargeScreen ? 20 : 16,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               side: const BorderSide(
//                                 color: Color(0xFF757575),
//                                 width: 2,
//                               ),
//                             ),
//                             child: Text(
//                               'Back',
//                               style: TextStyle(
//                                 fontSize: isLargeScreen ? 18 : 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: isLargeScreen ? 24 : 16),
//                         Expanded(
//                           flex: 2,
//                           child: ElevatedButton(
//                             onPressed: _proceedToPayment,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF4CAF50),
//                               padding: EdgeInsets.symmetric(
//                                 vertical: isLargeScreen ? 20 : 16,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 4,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Proceed to Payment',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: isLargeScreen ? 18 : 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLargeScreenForm() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: _buildTextField(
//                 _nameController,
//                 'Full Name',
//                 Icons.person_outline,
//                 false,
//               ),
//             ),
//             const SizedBox(width: 24),
//             Expanded(
//               child: _buildTextField(
//                 _mobileController,
//                 'Mobile Number',
//                 Icons.phone,
//                 false,
//                 isPhone: true,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         _buildTextField(_addressController, 'Address', Icons.home, true),
//         const SizedBox(height: 24),
//         Row(
//           children: [
//             Expanded(child: _buildGenderDropdown()),
//             const SizedBox(width: 24),
//             Expanded(child: _buildDateField()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildMobileForm() {
//     return Column(
//       children: [
//         _buildTextField(
//           _nameController,
//           'Full Name',
//           Icons.person_outline,
//           false,
//         ),
//         const SizedBox(height: 16),
//         _buildTextField(
//           _mobileController,
//           'Mobile Number',
//           Icons.phone,
//           false,
//           isPhone: true,
//         ),
//         const SizedBox(height: 16),
//         _buildTextField(_addressController, 'Address', Icons.home, true),
//         const SizedBox(height: 16),
//         _buildGenderDropdown(),
//         const SizedBox(height: 16),
//         _buildDateField(),
//       ],
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String label,
//     IconData icon,
//     bool multiline, {
//     bool isPhone = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: '$label *',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(width: 2),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
//         ),
//         prefixIcon: Icon(icon, color: const Color(0xFF2196F3)),
//         filled: true,
//         fillColor: Colors.grey[50],
//       ),
//       maxLines: multiline ? 3 : 1,
//       maxLength: isPhone ? 10 : null,
//       keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         if (isPhone && value.length != 10) {
//           return 'Please enter valid 10-digit number';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildGenderDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedGender,
//       decoration: InputDecoration(
//         labelText: 'Gender *',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(width: 2),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
//         ),
//         prefixIcon: const Icon(Icons.wc, color: Color(0xFF2196F3)),
//         filled: true,
//         fillColor: Colors.grey[50],
//       ),
//       items: const [
//         DropdownMenuItem(value: 'Male', child: Text('Male')),
//         DropdownMenuItem(value: 'Female', child: Text('Female')),
//         DropdownMenuItem(value: 'Other', child: Text('Other')),
//       ],
//       onChanged: (value) {
//         setState(() {
//           _selectedGender = value;
//         });
//       },
//       validator: (value) {
//         if (value == null) {
//           return 'Please select gender';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildDateField() {
//     return InkWell(
//       onTap: () => _selectDate(context),
//       child: InputDecorator(
//         decoration: InputDecoration(
//           labelText: 'Visit Date *',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(width: 2),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
//           ),
//           prefixIcon: const Icon(
//             Icons.calendar_today,
//             color: Color(0xFF2196F3),
//           ),
//           filled: true,
//           fillColor: Colors.grey[50],
//         ),
//         child: Text(
//           _selectedDate == null
//               ? 'Select Date'
//               : DateFormat('dd MMM yyyy').format(_selectedDate!),
//           style: TextStyle(
//             color: _selectedDate == null ? Colors.grey[600] : Colors.black87,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTicketCounter(
//     String label,
//     int count,
//     double price,
//     bool isLarge,
//     bool isAdult,
//   ) {
//     return Container(
//       padding: EdgeInsets.all(isLarge ? 24 : 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey[300]!, width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(
//             isAdult ? Icons.person : Icons.child_care,
//             size: isLarge ? 40 : 32,
//             color: isAdult ? Colors.green : Colors.blue,
//           ),
//           SizedBox(height: isLarge ? 16 : 12),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: isLarge ? 20 : 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: isLarge ? 16 : 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     if (isAdult && _adults > 1) _adults--;
//                     if (!isAdult && _children > 0) _children--;
//                   });
//                 },
//                 icon: const Icon(Icons.remove_circle),
//                 color: Colors.red,
//                 iconSize: isLarge ? 36 : 28,
//               ),
//               SizedBox(
//                 width: isLarge ? 60 : 50,
//                 child: Text(
//                   isAdult ? '$_adults' : '$_children',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: isLarge ? 32 : 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     if (isAdult && _adults < 10) _adults++;
//                     if (!isAdult && _children < 10) _children++;
//                   });
//                 },
//                 icon: const Icon(Icons.add_circle),
//                 color: Colors.green,
//                 iconSize: isLarge ? 36 : 28,
//               ),
//             ],
//           ),
//           SizedBox(height: isLarge ? 12 : 8),
//           Text(
//             '₹${price.toStringAsFixed(0)} each',
//             style: TextStyle(
//               fontSize: isLarge ? 16 : 14,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
