import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torbanticketing/config/responsive.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final istab = Responsive.isTablet(context);
    final istabmobile = Responsive.isMobtab(context);
    final ismob = Responsive.isMobile(context);
    final isdesk = Responsive.isDesktop(context);
    final istabdesk = Responsive.isTabDesk(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- HEADER ----------------
          Container(
            color: Colors.blue[50],
            child: Padding(
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
                vertical: istabmobile
                    ? 30
                    : ismob
                    ? 25
                    : 40,
              ),
              child: Row(
                children: [
                  Text(
                    'Terms & Conditions',
                    style: GoogleFonts.inter(
                      fontSize: ismob ? 26 : 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------------- CONTENT ----------------
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
              vertical: istabmobile
                  ? 30
                  : ismob
                  ? 25
                  : 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ----------------------------------------------------
                // MERCHANT INFO CARD
                // ----------------------------------------------------
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
                      // Row(
                      //   children: const [
                      //     Icon(
                      //       Icons.business,
                      //       color: Color(0xFF1976D2),
                      //       size: 24,
                      //     ),
                      //     SizedBox(width: 10),
                      //     Text(
                      //       'Merchant Information',
                      //       style: TextStyle(
                      //         fontSize: 22,
                      //         fontWeight: FontWeight.bold,
                      //         color: Color(0xFF1976D2),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),

                      // _buildInfoRow(
                      //   'Merchant:',
                      //   'PG_Cubeten Technologies Private Limited',
                      // ),
                      // const SizedBox(height: 8),
                      _buildInfoRow('Website:', 'https://imphalsmartcity.in'),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ----------------------------------------------------
                // WELCOME BOX
                // ----------------------------------------------------
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Welcome to the official Kangla Nongpok Torban Ticket website. By accessing this portal, purchasing tickets, or using any related services, you agree to the following Terms & Conditions. Please read them carefully before proceeding.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // ----------------------------------------------------
                // ALL TERMS SECTIONS
                // ----------------------------------------------------
                _buildTermsSection('1. General Terms', [
                  'This website is the official portal for ticket booking, event details, schedules, and official updates related to the Kangla Nongpok Torban.',
                  'The festival organizers reserve the right to update or modify these Terms & Conditions at any time without prior notice.',
                ]),

                _buildTermsSection(
                  '2. Online Ticket Booking',
                  [],
                  subsections: [
                    {
                      'title': '2.1 Ticket Fee Payment',
                      'points': [
                        'Customers are advised to make payments only through the official portal.',
                        'Valid bank accounts or supported digital payment methods must be used.',
                      ],
                    },
                    {
                      'title': '2.2 Accepted Payment Modes',
                      'points': [
                        'UPI',
                        // 'Credit/Debit Cards',
                        // 'Net Banking',
                        // 'Digital Wallets',
                      ],
                    },
                    {
                      'title': '2.3 Booking Instructions',
                      'points': [
                        'Follow on-screen instructions carefully while booking.',
                        'Select preferred payment mode at the gateway and complete the transaction.',
                      ],
                    },
                  ],
                ),

                _buildTermsSection('3. Transaction Fee Charges', [
                  'No additional transaction fee is charged separately.',
                ]),

                _buildTermsSection('4. Payment Confirmation & Ticket Download', [
                  'After a successful payment, you will be redirected back to the portal.',
                  'Tickets can then be downloaded immediately.',
                  'If redirection fails, users should check transaction status or contact support.',
                ]),

                _buildTermsSection('5. User Responsibilities', [
                  'Users must ensure all personal data entered is accurate.',
                  'The website must not be used for fraudulent activities.',
                  'Users are responsible for the confidentiality of login and transaction data.',
                ]),

                _buildTermsSection(
                  '6. Limitation of Liability',
                  ['The organizers shall not be responsible for:'],
                  bulletPoints: [
                    'Network issues or internet connectivity failure',
                    'Payment gateway downtime',
                    'Incorrect information entered by the user',
                  ],
                  additionalText:
                      'Website content may be updated periodically and may change without notice.',
                ),

                _buildTermsSection('7. Refund and Cancellation Policy', [
                  'All sales are final and non-refundable unless the event is canceled.',
                  'Refunds will be processed within 7–10 working days in case of cancellation.',
                  'Ticket transfers are not allowed without prior approval.',
                ]),

                _buildTermsSection('8. Governing Law', [
                  'These Terms & Conditions are governed by the laws of Manipur, India.',
                ]),

                const SizedBox(height: 40),

                // ----------------------------------------------------
                // IMPORTANT NOTICE
                // ----------------------------------------------------
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: Colors.orange[900],
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Important Notice',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'By proceeding with ticket booking, you acknowledge that you have fully read and agree to these Terms & Conditions.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.orange[900],
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------
  // COMPONENTS
  // ----------------------------------------------------------------------

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 15, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection(
    String title,
    List<String> points, {
    List<Map<String, dynamic>>? subsections,
    List<String>? bulletPoints,
    String? additionalText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),

          // MAIN BULLET POINTS
          ...points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Color(0xFF1976D2),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      p,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SUB-SECTIONS
          if (subsections != null)
            ...subsections.map(
              (s) => Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...(s['points'] as List<String>).map(
                      (pt) => Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("• ", style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                pt,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // BULLETS UNDER A MAIN POINT
          if (bulletPoints != null)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bulletPoints
                    .map(
                      (pt) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("◦ ", style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                pt,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

          // EXTRA TEXT
          if (additionalText != null)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12),
              child: Text(
                additionalText,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
