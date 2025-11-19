import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torbanticketing/controller/pagecon.dart';
import 'package:torbanticketing/view/aboutus.dart';
import 'package:torbanticketing/view/contactus.dart';
import 'package:torbanticketing/view/home.dart';
import 'package:torbanticketing/view/privacypage.dart';
import 'package:torbanticketing/view/refundandpolicy.dart';
import 'package:torbanticketing/view/termsandcondition.dart';

// Import your existing pages
// import 'your_pages_file.dart'; // HomeContent, BookingPage, AboutPage, ContactPage

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _pages = [
    const HomeContent(),
    TermsAndConditionsPage(),
    const AboutPage(),
    const ContactPage(),
    // PrivacyPolicyPage(),
    // CancelRefundPolicyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Pagemanagementcontroller pngcon = Get.put(Pagemanagementcontroller());
    return GetBuilder<Pagemanagementcontroller>(
      builder: (_) {
        log("Selected Index : " + pngcon.selectedIndex.toString());
        return Scaffold(
          body: Column(
            children: [
              _buildTopNavBar(context, pngcon),
              Expanded(
                child: SingleChildScrollView(
                  controller: pngcon.scrollController,
                  child: Column(
                    children: [
                      pngcon.selectedIndex == 4
                          ? PrivacyPolicyPage()
                          : pngcon.selectedIndex == 5
                          ? CancelRefundPolicyPage()
                          : _pages[pngcon.selectedIndex],
                      _buildFooter(pngcon),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopNavBar(
    BuildContext context,
    Pagemanagementcontroller pngcon,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth >= 900 && screenWidth < 1200;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo and Title
            Row(
              children: [
                const Icon(Icons.water, color: Color(0xFF1976D2), size: 36),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isMobile ? 'Torban' : 'Kangla Nongpok Torban',
                      style: TextStyle(
                        color: const Color(0xFF1976D2),
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 18 : 22,
                      ),
                    ),
                    if (!isMobile)
                      Text(
                        'Imphal Smart City',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                  ],
                ),
              ],
            ),
            // Navigation Links
            if (!isMobile)
              Row(
                children: [
                  _buildNavLink('Home', 0, pngcon),
                  const SizedBox(width: 10),
                  _buildNavLink('Terms and Condition', 1, pngcon),
                  const SizedBox(width: 10),
                  _buildNavLink('About Us', 2, pngcon),
                  const SizedBox(width: 10),
                  _buildNavLink('Contact', 3, pngcon),
                ],
              )
            else
              // Mobile Menu
              PopupMenuButton<int>(
                color: Colors.white,
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xFF1976D2),
                  size: 28,
                ),
                offset: const Offset(0, 50),
                onSelected: pngcon.onNavItemTapped,
                itemBuilder: (context) => [
                  _buildPopupMenuItem('Home', 0, Icons.home, pngcon),
                  _buildPopupMenuItem(
                    'Terms and Condition',
                    1,
                    Icons.confirmation_number,
                    pngcon,
                  ),
                  _buildPopupMenuItem('About Us', 2, Icons.info, pngcon),
                  _buildPopupMenuItem('Contact', 3, Icons.contact_mail, pngcon),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(
    String label,
    int index,
    Pagemanagementcontroller pngcon,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => pngcon.onNavItemTapped(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: pngcon.selectedIndex == index
                ? const Color.fromARGB(255, 144, 189, 235).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            // border: isSelected
            //     ? Border.all(
            //         color: const Color.fromARGB(255, 217, 240, 220),
            //         width: 2,
            //       )
            //     : null,
          ),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: pngcon.selectedIndex == index
                      ? const Color(0xFF1976D2)
                      : Colors.grey[700],
                  fontWeight: pngcon.selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(
    String label,
    int index,
    IconData icon,
    Pagemanagementcontroller pngcon,
  ) {
    return PopupMenuItem<int>(
      value: index,
      child: Row(
        children: [
          Icon(
            icon,
            color: pngcon.selectedIndex == index
                ? const Color(0xFF1976D2)
                : Colors.grey[700],
            size: 22,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: pngcon.selectedIndex == index
                  ? const Color(0xFF1976D2)
                  : Colors.grey[800],
              fontWeight: pngcon.selectedIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(Pagemanagementcontroller pngcon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 14, 27),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.1),
          //   blurRadius: 10,
          //   offset: const Offset(0, -2),
          // ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;
            final isTablet =
                constraints.maxWidth >= 768 && constraints.maxWidth < 1200;
            return isMobile
                ? _buildMobileFooter(pngcon)
                : (isTablet
                      ? _buildTabletFooter(pngcon)
                      : _buildDesktopFooter(pngcon));
          },
        ),
      ),
    );
  }

  Widget _buildMobileFooter(Pagemanagementcontroller pngcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.water, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            const Text(
              'Kangla Nongpok Torban',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Imphal Smart City Limited',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 30),
        _buildFooterSection('Quick Links', [
          _buildFooterLink('Terms and Condition', 1, pngcon),
          _buildFooterLink('Privacy', 4, pngcon),
          _buildFooterLink('Cancel and Refund', 5, pngcon),
          _buildFooterLink('About', 2, pngcon),
          _buildFooterLink('Contact', 3, pngcon),
        ]),
        const SizedBox(height: 25),
        _buildFooterSection('Contact Info', [
          _buildFooterText('📍 PDA COMPLEX NORTH AOC,'),
          _buildFooterText('   Imphal West, Manipur - 795001'),
          // _buildFooterText('📞 +91-385-XXXXXXX'),
          _buildFooterText('✉️  imphalscl@hotmail.com'),
        ]),
        const SizedBox(height: 25),
        _buildFooterSection('Opening Hours', [
          _buildFooterText('🕐 Daily: 6:00 AM - 8:00 PM'),
          const SizedBox(height: 10),
          _buildFooterText('💳 Entry Fee:'),
          _buildFooterText('   Adults: ₹20'),
          _buildFooterText('   Children: ₹10'),
        ]),
        const SizedBox(height: 25),
        // Social Media
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(Icons.facebook),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.camera_alt),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.phone),
          ],
        ),
        const SizedBox(height: 25),
        const Divider(color: Colors.white24, thickness: 1),
        const SizedBox(height: 15),
        _buildCopyright(),
      ],
    );
  }

  Widget _buildTabletFooter(Pagemanagementcontroller pngcon) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.water, color: Colors.white, size: 45),
                  const SizedBox(height: 15),
                  const Text(
                    'Kangla Nongpok Torban',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A 700-meter riverside recreation hub along the Imphal River, developed under Imphal Smart City Limited.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _buildFooterSection('Quick Links', [
                _buildFooterLink('Terms and Condition', 1, pngcon),
                _buildFooterLink('Privacy', 4, pngcon),
                _buildFooterLink('Cancel and Refund', 5, pngcon),
                _buildFooterLink('About', 2, pngcon),
                _buildFooterLink('Contact', 3, pngcon),
              ]),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _buildFooterSection('Contact Info', [
                _buildFooterText('📍 PDA COMPLEX NORTH AOC,'),
                _buildFooterText('   Imphal West, Manipur - 795001'),
                // _buildFooterText('📞 +91-385-XXXXXXX'),
                _buildFooterText('✉️  imphalscl@hotmail.com'),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 30),
        const Divider(color: Colors.white24, thickness: 1),
        const SizedBox(height: 20),
        _buildCopyright(),
      ],
    );
  }

  Widget _buildDesktopFooter(Pagemanagementcontroller pngcon) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Section
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.water, color: Colors.white, size: 50),
                      SizedBox(width: 15),
                      Text(
                        'Kangla Nongpok\nTorban',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'A 700-meter riverside recreation hub along the Imphal River, developed under Imphal Smart City Limited initiative. Experience scenic views, family-friendly activities, and modern amenities.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildSocialIcon(Icons.facebook),
                      const SizedBox(width: 12),
                      _buildSocialIcon(Icons.camera_alt),
                      const SizedBox(width: 12),
                      _buildSocialIcon(Icons.phone),
                      const SizedBox(width: 12),
                      _buildSocialIcon(Icons.mail),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 60),
            // Quick Links
            Expanded(
              child: _buildFooterSection('Quick Links', [
                _buildFooterLink('Terms and Condition', 1, pngcon),
                _buildFooterLink('Privacy', 4, pngcon),
                _buildFooterLink('Cancel and Refund', 5, pngcon),
                _buildFooterLink('About', 2, pngcon),
                _buildFooterLink('Contact', 3, pngcon),
              ]),
            ),
            const SizedBox(width: 60),
            // Contact Info
            Expanded(
              flex: 2,
              child: _buildFooterSection('Contact Information', [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white70,
                      size: 18,
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: _buildFooterText(
                        'PDA COMPLEX NORTH AOC\nImphal West, Manipur - 795001',
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 5),
                // Row(
                //   children: [
                //     const Icon(Icons.phone, color: Colors.white70, size: 18),
                //     const SizedBox(width: 8),
                //     _buildFooterText('+91-385-XXXXXXX'),
                //   ],
                // ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.white70, size: 18),
                    const SizedBox(width: 8),
                    _buildFooterText('imphalscl@hotmail.com'),
                  ],
                ),
              ]),
            ),
            const SizedBox(width: 60),
            // Opening Hours
            Expanded(
              flex: 2,
              child: _buildFooterSection('Opening Hours & Pricing', [
                _buildFooterText('🕐 Daily: 6:00 AM - 8:00 PM'),
                const SizedBox(height: 15),
                _buildFooterText('Entry Fees:', bold: true),
                _buildFooterText('Adults: ₹20 per person'),
                _buildFooterText('Children (5-12): ₹10'),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Divider(color: Colors.white24, thickness: 1.5),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© ${DateTime.now().year} Kangla Nongpok Torban. All rights reserved.',
              style: const TextStyle(color: Colors.white60, fontSize: 13),
            ),
            // Text(
            //   'Managed by Imphal Smart City Limited',
            //   style: const TextStyle(color: Colors.white60, fontSize: 13),
            // ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 15),
        ...children,
      ],
    );
  }

  Widget _buildFooterLink(
    String text,
    int index,
    Pagemanagementcontroller pngcon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => pngcon.onNavItemTapped(index),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterText(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildCopyright() {
    return Center(
      child: Text(
        '© ${DateTime.now().year} Kangla Nongpok Torban. All rights reserved.',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white60, fontSize: 12),
      ),
    );
  }
}
