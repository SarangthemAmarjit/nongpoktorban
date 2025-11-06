// Home Page - Optimized for Web
import 'package:flutter/material.dart';
import 'package:torbanticketing/main.dart';
import 'package:torbanticketing/view/booking.dart';
import 'package:torbanticketing/widget/pricecard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 800;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 113, 179, 115),
              Color.fromARGB(255, 128, 163, 192),
              Color.fromARGB(255, 198, 125, 211),
            ],
          ),
        ),
        child: ResponsiveCenter(
          maxWidth: isLargeScreen ? 1200 : 600,
          child: Padding(
            padding: EdgeInsets.all(isLargeScreen ? 48.0 : 24.0),
            child: Center(
              child: Card(
                elevation: 16,
                shadowColor: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: isLargeScreen ? 500 : double.infinity,
                  ),
                  padding: EdgeInsets.all(isLargeScreen ? 48 : 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: isLargeScreen ? 100 : 80,
                        height: isLargeScreen ? 100 : 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4CAF50), Color(0xFF2196F3)],
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.confirmation_number,
                          size: isLargeScreen ? 50 : 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: isLargeScreen ? 32 : 24),
                      Text(
                        'Nongpok Torban Park',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 35 : 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF212121),
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: isLargeScreen ? 16 : 8),
                      Text(
                        'Experience nature\'s beauty and thrilling adventures',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isLargeScreen ? 18 : 16,
                          color: const Color(0xFF757575),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: isLargeScreen ? 40 : 32),
                      buildPriceCard(
                        'Adult Ticket',
                        adultPrice,
                        Colors.green,
                        isLargeScreen,
                      ),
                      const SizedBox(height: 20),
                      buildPriceCard(
                        'Child Ticket',
                        childPrice,
                        Colors.blue,
                        isLargeScreen,
                      ),
                      SizedBox(height: isLargeScreen ? 40 : 32),
                      SizedBox(
                        width: double.infinity,
                        height: isLargeScreen ? 64 : 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                            shadowColor: Colors.green.withOpacity(0.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Book Tickets Now',
                                style: TextStyle(
                                  fontSize: isLargeScreen ? 20 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
