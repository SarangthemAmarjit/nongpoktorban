import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torbanticketing/config/responsive.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final istab = Responsive.isTablet(context);
    final istabmobile = Responsive.isMobtab(context);
    final ismob = Responsive.isMobile(context);
    final isdesk = Responsive.isDesktop(context);
    final istabdesk = Responsive.isTabDesk(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------------- HEADER / BREADCRUMB SECTION ----------------------
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
                Expanded(
                  child: Text(
                    "About Kangla Nongpok Torban",
                    style: GoogleFonts.inter(
                      fontSize: ismob ? 26 : 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ---------------------------- CONTENT SECTION -----------------------------
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
              _buildSection("Overview", '''
Kangla Nongpok Torban, also known as the Eastern Bank of the Kangla, is a modern riverside recreation area developed under the Imphal Smart City Limited initiative. Located on the eastern bank of the Imphal River, this 700-meter stretch runs from Sanjenthong Bridge to Nongpok Thong, offering residents and visitors a beautiful space for relaxation, recreation, and community activities.
'''),

              _buildSection("Location & Accessibility", '''
• Located near Sanjenthong Bridge, Imphal
• Along the eastern bank of Imphal River
• Easily accessible from Imphal city center
• Well-connected by public transport
• 700 meters of developed recreational space
'''),

              _buildSection("Facilities & Amenities", '''
• Scenic riverside walking paths
• Public bicycle sharing system (Yaana App)
• Green spaces for relaxation
• Family-friendly environment
• Photography-friendly scenic spots
• Regular community events and programs
• Clean and well-maintained premises
'''),

              _buildSection("Visiting Information", '''
Opening Hours: 6:00 AM - 8:00 PM (Daily)

Entry Fees:
• Adults: ₹20 per person
• Children (5–12 years): ₹10 per person


Note: Entry fees help maintain and improve the facilities for all visitors.
'''),

              _buildSection("Smart City Initiative", '''
As part of the Imphal Smart City project, Kangla Nongpok Torban represents a significant development in urban recreational infrastructure. The initiative aims to provide modern, sustainable, and accessible public spaces for the people of Imphal. The project also includes eco-friendly initiatives like the bicycle sharing program and green spaces.
'''),

              _buildSection("Future Development", '''
Phase 2 of the development is planned to extend the recreational area from Nongpok Thong to Minuthong, further expanding the space for public recreation and community activities.
'''),

              _buildSection("Visitor Guidelines", '''
• Maintain cleanliness – use designated waste bins  
• Respect other visitors and their space  
• Follow safety guidelines near the river  
• No littering or defacing of property  
• Keep the environment green and clean  
• Photography allowed for personal use  
• Follow instructions from staff and security  
'''),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------- REUSABLE SECTION WIDGET ----------------------------
  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
