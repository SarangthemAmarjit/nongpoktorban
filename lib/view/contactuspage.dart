import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torbanticketing/config/responsive.dart';
import 'package:torbanticketing/widget/custombutton.dart';
import 'package:torbanticketing/widget/textfield.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key});
  int rating = 5;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _mailController = TextEditingController();
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final istab = Responsive.isTablet(context);
    final istabmobile = Responsive.isMobtab(context);
    final ismob = Responsive.isMobile(context);
    final istabdesk = Responsive.isTabDesk(context);

    return Column(
      children: [
        // Gradient Header
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            // gradient: LinearGradient(
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            //   colors: [Color(0xFFD2E7F3), Color(0xFFFDF1EB)],
            // ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: istabdesk
                ? 130
                : istab
                ? 100
                : istabmobile
                ? 80
                : ismob
                ? 50
                : 150,
            vertical: ismob ? 25 : 40,
          ),
          child: Text(
            'Contact Us',
            style: GoogleFonts.inter(
              fontSize: ismob ? 28 : 40,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),

        // Main Content
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: istabdesk
                ? 130
                : istab
                ? 100
                : istabmobile
                ? 80
                : ismob
                ? 50
                : 150,
            vertical: ismob ? 25 : 40,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildForm(),
                    const SizedBox(height: 40),
                    _buildContactInfo(),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildForm()),
                        const SizedBox(width: 30),
                        Expanded(child: _buildContactInfo()),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  // Widget _buildForm() {
  //   return Column(
  //     children: [
  //       _customInput(height: 200, hint: 'Enter Message', maxLines: 6),
  //       const SizedBox(height: 12),
  //       Row(
  //         children: [
  //           Expanded(child: _customInput(hint: 'Enter your name')),
  //           const SizedBox(width: 10),
  //           Expanded(child: _customInput(hint: 'Email')),
  //         ],
  //       ),
  //       const SizedBox(height: 12),
  //       _customInput(hint: 'Enter Subject'),
  //       const SizedBox(height: 20),
  //       Align(
  //         alignment: Alignment.centerLeft,
  //         child: Custombutton(buttonname: 'Submit'),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildForm() {
    // final AdminController admincon = Get.put(AdminController());

    return StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              buildTextField(
                label: 'Name',

                hintText: 'Enter Your Name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              buildTextField(
                label: 'Email',
                hintText: 'Enter Your Email',
                controller: _mailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              buildTextField(
                label: 'Phone Number',
                hintText: 'Enter Your Phone Number',
                controller: _numberController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Star Rating

              // Review Field
              buildTextField(
                label: 'Message',
                hintText: 'Write your Message...',

                maxLines: 6,
                controller: _messageController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Message is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Submit Button
              Align(
                alignment: Alignment.centerLeft,
                child: Custombutton(
                  issubmitbutton: true,
                  buttonname: 'Submit',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // admincon.submitReview(
                      //   name: _nameController.text,
                      //   rating: rating,
                      //   review: _reviewController.text,
                      //   context: context,
                      // );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _customInput({
    String hint = '',
    double height = 50,
    int maxLines = 1,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0.8),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.location_on, color: Colors.green),
            title: Text("Address"),
            subtitle: Text(
              "Kangla Nongpok Torban\nPDA COMPLEX NORTH AOC\nImphal West, Manipur - 795001",
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.email, color: Colors.blue),
            title: Text("Email"),
            subtitle: Text("imphalscl@hotmail.com"),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.access_time, color: Colors.indigo),
            title: Text("Operating Hours"),
            subtitle: Text("6:00 AM - 8:00 PM (Daily)"),
          ),
        ],
      ),
    );
  }
}
