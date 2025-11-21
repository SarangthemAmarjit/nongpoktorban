import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torbanticketing/config/responsive.dart';
import 'package:torbanticketing/routes/app_routes.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _buildInfoSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600; // adjust breakpoint as needed

    final infoCards = [
      _buildInfoCard(
        icon: Icons.access_time,
        title: 'Opening Hours',
        description: 'Open Daily\n6:00 AM - 8:00 PM',
        color: const Color(0xFF1976D2),
      ),
      _buildInfoCard(
        icon: Icons.currency_rupee,
        title: 'Entry Fee',
        description: 'Adults: ₹20\nChildren: ₹10',
        color: const Color(0xFF388E3C),
      ),
      _buildInfoCard(
        icon: Icons.location_on,
        title: 'Location',
        description: 'PDA COMPLEX NORTH AOC\nImphal West, Manipur - 795001',
        color: const Color(0xFFD32F2F),
      ),
      // _buildInfoCard(
      //   icon: Icons.directions_bike,
      //   title: 'Bicycle Sharing',
      //   description: 'Yaana App Available\nPublic Cycles',
      //   color: const Color(0xFFF57C00),
      // ),
    ];

    return isMobile
        ? GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
            children: infoCards,
          )
        : Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: infoCards,
          );
  }

  Widget _buildFeatureSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600; // breakpoint for mobile

    final featureCards = [
      _buildFeatureCard(
        image: 'assets/images/icons/scenic.webp',
        title: 'Scenic Views',
        description: 'Beautiful riverside walking paths',
        color: const Color.fromARGB(255, 117, 216, 120).withOpacity(0.5),
      ),
      _buildFeatureCard(
        image: 'assets/images/icons/family.webp',
        title: 'Family Friendly',
        description: 'Perfect for all age groups',
        color: const Color.fromARGB(255, 113, 167, 211).withOpacity(0.5),
      ),
      _buildFeatureCard(
        image: 'assets/images/icons/photographer.webp',
        title: 'Photography',
        description: 'Instagram-worthy spots',
        color: const Color.fromARGB(255, 215, 177, 120).withOpacity(0.5),
      ),
      _buildFeatureCard(
        image: 'assets/images/icons/calendar.webp',
        title: 'Events & Activities',
        description: 'Regular community programs',
        color: const Color.fromARGB(255, 194, 117, 207).withOpacity(0.5),
      ),
    ];

    return isMobile
        ? GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: featureCards,
          )
        : Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: featureCards,
          );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            // height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/bg.webp'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                    0.4,
                  ), // adjust 0.5 for more/less darkness
                  BlendMode.darken,
                ),
              ),
            ),

            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.water, size: 80, color: Colors.white),
                    const SizedBox(height: 20),
                    const Text(
                      'Kangla Nongpok Torban',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Riverside Recreation Hub by Imphal River',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Near Sanjenthong Bridge, Imphal',
                      style: TextStyle(fontSize: 16, color: Colors.white60),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.ticketbookingscreen);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color.fromARGB(
                          255,
                          240,
                          174,
                          68,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        'Book Your Entry Pass',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Quick Info Cards
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  Responsive.isMobile(context) || Responsive.isTablet(context)
                  ? 20
                  : 40,
            ),
            child: _buildInfoSection(context),
          ),
          const SizedBox(height: 40),
          // Features Section
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 20 : 40,
              vertical: 40,
            ),

            child: Column(
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  'Experience The Best of Imphal',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  '700 meters of riverside recreation area',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),
                _buildFeatureSection(context),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Smart City Initiative
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const Icon(
                  Icons.location_city,
                  size: 60,
                  color: Color(0xFF1976D2),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Imphal Smart City Project',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    'Kangla Nongpok Torban is developed under the Imphal Smart City Limited initiative, '
                    'bringing modern recreational facilities to the heart of Imphal. From Sanjenthong to '
                    'Nongpok Thong, this 700-meter stretch offers a refreshing escape along the Imphal River.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 10,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 15),
            Text(
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String image,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      width: 220,
      height: 190,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 176, 175, 175)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 50),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 46, 83),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(221, 73, 73, 73),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTicketCounter(String label, int count, Function(int) onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        Row(
          children: [
            IconButton(
              onPressed: count > 0 ? () => onChanged(count - 1) : null,
              icon: const Icon(Icons.remove_circle_outline),
              color: const Color(0xFF1976D2),
            ),
            Container(
              width: 50,
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () => onChanged(count + 1),
              icon: const Icon(Icons.add_circle_outline),
              color: const Color(0xFF1976D2),
            ),
          ],
        ),
      ],
    ),
  );
}
