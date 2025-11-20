import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torbanticketing/config/const.dart';
import 'package:torbanticketing/config/responsive.dart';
import 'package:torbanticketing/controller/managementcontroller.dart';
import 'package:torbanticketing/controller/pagecon.dart';
import 'package:torbanticketing/view/summary.dart';

class TicketBookingScreen extends StatefulWidget {
  const TicketBookingScreen({super.key});

  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  int _adultTickets = 1;
  int _childTickets = 0;
  String? _selectedGender;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mailaddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Pagemanagementcontroller pagecontroller = Get.put(
      Pagemanagementcontroller(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<Pagemanagementcontroller>(
        builder: (_) {
          return CustomScrollView(
            slivers: [
              // Header Section
              SliverAppBar(
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Background Image
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/kanglanongpok.webp',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                      // Content
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Book Your Tickets',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        Responsive.isMobtab(context) ||
                            Responsive.isMobile(context)
                        ? 10
                        : 150,
                    vertical: 32,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        241,
                        253,
                        227,
                      ).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF454749)
                            : const Color(0xFFE9ECEF),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        Responsive.isMobile(context) ? 20 : 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Progress Bar
                          _buildProgressBar(),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  pagecontroller.currentPage == 1
                                      ? 'Enter Visitor Information'
                                      : pagecontroller.currentPage == 2
                                      ? isofflinepay
                                            ? "Select your Tickets"
                                            : 'Select Tickets & Payment'
                                      : 'Booking Summary',
                                  style: TextStyle(
                                    fontSize: Responsive.isMobile(context)
                                        ? 25
                                        : 28,
                                    fontWeight: FontWeight.w900,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              pagecontroller.currentPage == 2
                                  ? IconButton(
                                      onPressed: () {
                                        pagecontroller.setPage(1);
                                      },
                                      icon: Icon(Icons.close),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Visitor Information
                          pagecontroller.currentPage == 1
                              ? Column(
                                  children: [
                                    Responsive.isMobile(context)
                                        ? _buildVisitorInformationformob(
                                            colorScheme,
                                          )
                                        : _buildVisitorInformation(colorScheme),
                                    const SizedBox(height: 24),

                                    // Divider
                                    Divider(
                                      color: isDark
                                          ? const Color(0xFF454749)
                                          : const Color(0xFFE9ECEF),
                                      height: 1,
                                    ),
                                    const SizedBox(height: 24),

                                    // // Ticket Selection
                                    // _buildTicketSelection(colorScheme),
                                    // const SizedBox(height: 24),

                                    // CTA Button
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: _buildProceedButton(colorScheme),
                                    ),
                                  ],
                                )
                              : ParkTicketsPage(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressBar() {
    Pagemanagementcontroller pagecontroller =
        Get.find<Pagemanagementcontroller>();
    return GetBuilder<Pagemanagementcontroller>(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pagecontroller.currentPage == 1
                  ? 'Step ${pagecontroller.currentPage} of 2: Your Details'
                  : 'Step ${pagecontroller.currentPage} of 2: Your Payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF454749)
                    : const Color(0xFFE9ECEF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width:
                      MediaQuery.of(context).size.width *
                      (pagecontroller.currentPage == 2 ? 0.80 : 0.40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A9D8F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVisitorInformationformob(ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: 'Full Name',
            hintText: 'Enter Your Name',
            controller: _nameController,
            validator: isofflinepay
                ? null
                : (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
          ),
          const SizedBox(height: 16),

          _buildTextField(
            label: 'Mobile Number',
            hintText: 'Enter Your Mobile Number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: isofflinepay
                ? null
                : (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
          ),
          const SizedBox(height: 16),

          _buildTextField(
            label: 'Address',
            hintText: 'Enter your address',
            controller: _addressController,
            validator: isofflinepay
                ? null
                : (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
          ),
          const SizedBox(height: 16),

          _buildTextField(
            label: 'Email Address',
            hintText: 'Enter Your Email Address',
            controller: _mailaddressController,
            keyboardType: TextInputType.emailAddress,
            validator: isofflinepay
                ? null
                : (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildVisitorInformation(ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Phone
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Full Name',
                  hintText: 'Enter Your Name',
                  controller: _nameController,
                  validator: isofflinepay
                      ? null
                      : (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'Mobile Number',
                  hintText: 'Enter Your Mobile Number',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: isofflinepay
                      ? null
                      : (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Address
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Address',
                  hintText: 'Enter your address',
                  controller: _addressController,
                  validator: isofflinepay
                      ? null
                      : (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'Email Address',
                  hintText: 'Enter Your Email Address',
                  controller: _mailaddressController,
                  keyboardType: TextInputType.emailAddress,
                  validator: isofflinepay
                      ? null
                      : (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLength: label == "Mobile Number" ? 10 : null,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: isDark
                  ? const Color(0xFF888A8B)
                  : const Color.fromARGB(255, 186, 190, 194),
            ),
            hintText: hintText,
            filled: true,
            fillColor: isDark
                ? const Color(0xFF1a1c1d)
                : const Color(0xFFF8F9FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark
                    ? const Color(0xFF454749)
                    : const Color.fromARGB(255, 239, 245, 245),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark
                    ? const Color(0xFF454749)
                    : const Color.fromARGB(255, 212, 212, 211),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF2A9D8F), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderRadio(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedGender,
          onChanged: (newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF2A9D8F);
            }
            return null;
          }),
        ),
        Text(
          label,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ],
    );
  }

  Widget _buildTicketSelection(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your Tickets',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),

        // Adult Tickets
        _buildTicketCounter(
          title: 'Adults',
          subtitle: 'Ages 13+',
          count: _adultTickets,
          onIncrement: () {
            setState(() {
              _adultTickets++;
            });
          },
          onDecrement: () {
            setState(() {
              if (_adultTickets > 0) _adultTickets--;
            });
          },
        ),
        const SizedBox(height: 12),

        // Child Tickets
        _buildTicketCounter(
          title: 'Children',
          subtitle: 'Ages 3-12',
          count: _childTickets,
          onIncrement: () {
            setState(() {
              _childTickets++;
            });
          },
          onDecrement: () {
            setState(() {
              if (_childTickets > 0) _childTickets--;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTicketCounter({
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1a1c1d) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF454749) : const Color(0xFFE9ECEF),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Decrement Button
              InkWell(
                onTap: onDecrement,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF454749)
                        : const Color(0xFFE9ECEF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Count
              SizedBox(
                width: 40,
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Increment Button
              InkWell(
                onTap: onIncrement,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF454749)
                        : const Color(0xFFE9ECEF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton(ColorScheme colorScheme) {
    Managementcontroller managementcontroller = Get.put(Managementcontroller());
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Get.find<Pagemanagementcontroller>().setPage(2);
            managementcontroller.setVisitorDetails(
              _nameController.text,
              _phoneController.text,
              _addressController.text,
              _mailaddressController.text,
            );
          }

          // Get.to(
          //   () => PaymentPage(
          //     mobile: '7005191566',
          //     gender: '',
          //     visitDate: DateTime(2),
          //     adults: 1,
          //     name: '',
          //     address: '',
          //     children: 1,
          //   ),
          // );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2A9D8F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Proceed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            // SizedBox(width: 8),
            // Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
