import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb-style Header
          Container(
            color: Colors.blue[50],
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 60 : 120),
              vertical: isMobile ? 25 : 40,
            ),
            child: Row(
              children: [
                Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 60 : 120),
              vertical: isMobile ? 25 : 40,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Info Card
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.info,
                                color: Color(0xFF1976D2),
                                size: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Contact Information',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1976D2),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          _buildContactItem(
                            Icons.location_on,
                            "Address",
                            "Kangla Nongpok Torban\nPDA COMPLEX NORTH AOC\nImphal West, Manipur - 795001",
                          ),

                          // _buildContactItem(
                          //   Icons.phone,
                          //   "Phone",
                          //   "+91-385-XXXXXXX",
                          // ),
                          _buildContactItem(
                            Icons.email,
                            "Email",
                            "imphalscl@hotmail.com",
                          ),
                          _buildContactItem(
                            Icons.access_time,
                            "Operating Hours",
                            "6:00 AM - 8:00 PM (Daily)",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Feedback Section Title
                    Text(
                      "Send us your feedback",
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Feedback Form Card
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          _buildInput("Name", Icons.person),
                          const SizedBox(height: 15),
                          _buildInput(
                            "Email",
                            Icons.email,
                            keyboard: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15),
                          _buildInput(
                            "Phone Number",
                            Icons.phone,
                            keyboard: TextInputType.phone,
                          ),
                          const SizedBox(height: 15),

                          // Message Box
                          TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "Message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.message),
                              alignLabelWithHint: true,
                            ),
                          ),
                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Color(0xFF1976D2),
                                    content: Text(
                                      "Thank you! Your message has been sent.",
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1976D2),
                              ),
                              child: const Text(
                                "Send Message",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Important Notice Card
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 28,
                            color: Color(0xFF1976D2),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              "• For immediate assistance, call during operating hours.\n"
                              "• Group bookings (15+ people) may require advance notice.\n"
                              "• Event-related inquiries are welcome.\n"
                              "• Email responses typically within 24–48 hours.",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.6,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF1976D2), size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
