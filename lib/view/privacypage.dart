import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torbanticketing/config/responsive.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                    'Privacy Policy',
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
                // MERCHANT CARD
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
                // SECTIONS
                // ----------------------------------------------------
                _buildSection(
                  'Policy Overview',
                  'The privacy policy governs the use of this website. CubeTen Technologies Pvt. Ltd. is committed to protecting applicants’ privacy and details to offer a useful, safe online experience.',
                ),

                _buildSection(
                  'Information Protection',
                  'Information provided, whether public or private, will not be sold, exchanged, transferred, or given to any other institution without consent from the provider, except when required by government agencies or under the R.T.I. Act, 2005.',
                ),

                _buildSection(
                  'Policy Changes',
                  'CubeTen Technologies Pvt. Ltd. reserves the right to change or modify any part of this agreement at any time. Continued use of the website constitutes acceptance of these terms and any changes.',
                ),

                _buildSection(
                  'Confidentiality',
                  'Personal information and service usage details will not be disclosed to third parties except when required by law or necessary to protect user rights.',
                ),

                _buildSection(
                  'Emails & Communication',
                  'CubeTen Technologies Pvt. Ltd. will not send unsolicited emails unless operationally or legally required. Users may unsubscribe anytime.',
                ),

                _buildSection(
                  'Anonymous Data',
                  'Anonymous statistical data may be collected to measure site usage and improve services. This data does not identify any individual.',
                ),

                _buildSection(
                  'Content Usage Restrictions',
                  'Content on this website cannot be copied, modified, uploaded, published, or distributed without explicit permission.',
                ),

                _buildSection(
                  'Copyright Notice',
                  'Reproduction of any website material without permission is prohibited and may violate copyright laws.',
                ),

                _buildSection(
                  'Legal Jurisdiction',
                  'All disputes fall under the jurisdiction of the High Court of Manipur.',
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // REUSABLE COMPONENTS
  // ================================================================

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

  Widget _buildSection(String title, String body) {
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
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              body,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}
