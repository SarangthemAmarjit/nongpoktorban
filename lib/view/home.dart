import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torbanticketing/view/formpage.dart';

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
        description: 'Near Sanjenthong Bridge\nImphal River Bank',
        color: const Color(0xFFD32F2F),
      ),
      _buildInfoCard(
        icon: Icons.directions_bike,
        title: 'Bicycle Sharing',
        description: 'Yaana App Available\nPublic Cycles',
        color: const Color(0xFFF57C00),
      ),
    ];

    return isMobile
        ? GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.95,
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
        icon: Icons.park,
        title: 'Scenic Views',
        description: 'Beautiful riverside walking paths',
        color: const Color.fromARGB(255, 117, 216, 120).withOpacity(0.5),
      ),
      _buildFeatureCard(
        icon: Icons.family_restroom,
        title: 'Family Friendly',
        description: 'Perfect for all age groups',
        color: const Color.fromARGB(255, 113, 167, 211).withOpacity(0.5),
      ),
      _buildFeatureCard(
        icon: Icons.photo_camera,
        title: 'Photography',
        description: 'Instagram-worthy spots',
        color: const Color.fromARGB(255, 215, 177, 120).withOpacity(0.5),
      ),
      _buildFeatureCard(
        icon: Icons.event,
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
            childAspectRatio: 1.1,
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 400,
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
                          Get.to(() => const TicketBookingScreen());
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: _buildInfoSection(context),
            ),
            const SizedBox(height: 40),
            // Features Section
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(40),

              child: Column(
                children: [
                  const Text(
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
    required IconData icon,
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
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  int adults = 0;
  int children = 0;
  int seniors = 0;
  String? selectedTimeSlot;

  final Map<String, int> prices = {'adults': 20, 'children': 10, 'seniors': 15};

  final List<String> timeSlots = [
    '6:00 AM - 8:00 AM',
    '8:00 AM - 10:00 AM',
    '10:00 AM - 12:00 PM',
    '12:00 PM - 2:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
    '6:00 PM - 8:00 PM',
  ];

  int calculateTotal() {
    return (adults * prices['adults']!) +
        (children * prices['children']!) +
        (seniors * prices['seniors']!);
  }

  int getTotalVisitors() {
    return adults + children + seniors;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.water, color: Color(0xFF1976D2), size: 32),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Book Entry Pass',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Date Selection
                  const Text(
                    'Select Visit Date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Time Slot Selection
                  const Text(
                    'Select Time Slot',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: selectedTimeSlot,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Choose your preferred time',
                    ),
                    items: timeSlots.map((String slot) {
                      return DropdownMenuItem<String>(
                        value: slot,
                        child: Text(slot),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedTimeSlot = value;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  // Visitor Count
                  const Text(
                    'Number of Visitors',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildTicketCounter('Adults (₹20)', adults, (val) {
                    setState(() => adults = val);
                  }),
                  _buildTicketCounter('Children 5-12 yrs (₹10)', children, (
                    val,
                  ) {
                    setState(() => children = val);
                  }),
                  _buildTicketCounter('Senior Citizens 60+ (₹15)', seniors, (
                    val,
                  ) {
                    setState(() => seniors = val);
                  }),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Color(0xFF1976D2),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Children below 5 years enter free',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 2),
                  const SizedBox(height: 20),
                  // Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Visitors:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${getTotalVisitors()} ${getTotalVisitors() == 1 ? "person" : "people"}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Total Amount:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '₹${calculateTotal()}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          (calculateTotal() > 0 && selectedTimeSlot != null)
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Booking Summary'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                      ),
                                      Text('Time: $selectedTimeSlot'),
                                      Text('Visitors: ${getTotalVisitors()}'),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Amount: ₹${calculateTotal()}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Proceeding to payment gateway...',
                                            ),
                                            backgroundColor: Color(0xFF1976D2),
                                          ),
                                        );
                                      },
                                      child: const Text('Confirm & Pay'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                      ),
                      child: const Text(
                        'Proceed to Payment',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About Kangla Nongpok Torban',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildSection(
                'Overview',
                'Kangla Nongpok Torban, also known as the Eastern Bank of the Kangla, is a modern riverside '
                    'recreation area developed under the Imphal Smart City Limited initiative. Located on the eastern '
                    'bank of the Imphal River, this 700-meter stretch runs from Sanjenthong Bridge to Nongpok Thong, '
                    'offering residents and visitors a beautiful space for relaxation, recreation, and community activities.',
              ),
              _buildSection(
                'Location & Accessibility',
                '• Located near Sanjenthong Bridge, Imphal\n'
                    '• Along the eastern bank of Imphal River\n'
                    '• Easily accessible from Imphal city center\n'
                    '• Well-connected by public transport\n'
                    '• 700 meters of developed recreational space',
              ),
              _buildSection(
                'Facilities & Amenities',
                '• Scenic riverside walking paths\n'
                    '• Public bicycle sharing system (Yaana App)\n'
                    '• Green spaces for relaxation\n'
                    '• Family-friendly environment\n'
                    '• Photography-friendly scenic spots\n'
                    '• Regular community events and programs\n'
                    '• Clean and well-maintained premises',
              ),
              _buildSection(
                'Visiting Information',
                'Opening Hours: 6:00 AM - 8:00 PM (Daily)\n\n'
                    'Entry Fees:\n'
                    '• Adults: ₹20 per person\n'
                    '• Children (5-12 years): ₹10 per person\n'
                    '• Senior Citizens (60+): ₹15 per person\n'
                    '• Children below 5 years: Free Entry\n\n'
                    'Note: Entry fees help maintain and improve the facilities for all visitors.',
              ),
              _buildSection(
                'Smart City Initiative',
                'As part of the Imphal Smart City project, Kangla Nongpok Torban represents a significant '
                    'development in urban recreational infrastructure. The initiative aims to provide modern, '
                    'sustainable, and accessible public spaces for the people of Imphal. The project also includes '
                    'eco-friendly initiatives like the bicycle sharing program and green spaces.',
              ),
              _buildSection(
                'Future Development',
                'Phase 2 of the development is planned to extend the recreational area from Nongpok Thong '
                    'to Minuthong, further expanding the available space for public recreation and community activities.',
              ),
              _buildSection(
                'Visitor Guidelines',
                '• Maintain cleanliness - use designated waste bins\n'
                    '• Respect other visitors and their space\n'
                    '• Follow safety guidelines near the river\n'
                    '• No littering or defacing of property\n'
                    '• Keep the environment green and clean\n'
                    '• Photography allowed for personal use\n'
                    '• Follow instructions from staff and security',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),
          const SizedBox(height: 10),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.6)),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  _buildContactItem(
                    Icons.location_on,
                    'Address',
                    'Kangla Nongpok Torban\nNear Sanjenthong Bridge\nImphal, Manipur - 795001',
                  ),
                  _buildContactItem(
                    Icons.apartment,
                    'Managed By',
                    'Imphal Smart City Limited (ISCL)',
                  ),
                  _buildContactItem(Icons.phone, 'Phone', '+91-385-XXXXXXX'),
                  _buildContactItem(Icons.email, 'Email', 'info@iscl.gov.in'),
                  _buildContactItem(
                    Icons.access_time,
                    'Operating Hours',
                    '6:00 AM - 8:00 PM (Daily)',
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Send us your feedback',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                            content: Text(
                              'Thank you! Your message has been sent successfully.',
                            ),
                            backgroundColor: Color(0xFF1976D2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                      ),
                      child: const Text(
                        'Send Message',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.info_outline, color: Color(0xFF1976D2)),
                            SizedBox(width: 10),
                            Text(
                              'Important Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '• For immediate assistance, please call during operating hours\n'
                          '• Group bookings (15+ people) may require advance notice\n'
                          '• Special event inquiries welcome\n'
                          '• We typically respond to emails within 24-48 hours',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[900],
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF1976D2), size: 30),
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
                const SizedBox(height: 5),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
