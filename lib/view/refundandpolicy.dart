import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torbanticketing/config/responsive.dart';

class CancelRefundPolicyPage extends StatelessWidget {
  const CancelRefundPolicyPage({super.key});

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
          // ---------------- HEADER SECTION ----------------
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
                    'Cancel & Refund Policy',
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

          // ---------------- MAIN CONTENT ----------------
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
                _buildPolicySection("General Policy", [
                  "All tickets issued through the official Kangla Nongpok Torban 2025 ticketing portal (https://imphalsmartcity.in) are non-refundable and non-returnable.",
                  "By purchasing a ticket, the buyer acknowledges and agrees to this policy.",
                ]),

                _buildPolicySection("No Cancellation Allowed", [
                  "Once a ticket is purchased or generated from the portal—whether paid online or redeemed through any promotional mechanism—it cannot be cancelled under any circumstances.",
                ]),

                _buildPolicySection("No Refund or Return", [
                  "No refund will be provided for any successfully purchased ticket.",
                  "No return or exchange of tickets is permitted.",
                  "This applies to all ticket types including general entry, event-specific passes, VIP passes, and any other category introduced for the festival.",
                ]),

                _buildPolicySection("Lost or Damaged Tickets", [
                  "The festival management and the ticketing portal are not responsible for lost, damaged, or misplaced tickets.",
                  "Duplicate or replacement tickets will not be issued.",
                ]),

                _buildPolicySection("Event Changes or Rescheduling", [
                  "If an event is rescheduled or modified due to unavoidable circumstances, the official announcement by the organizers will determine next steps.",
                  "Refunds will not be provided even in such cases.",
                ]),

                _buildPolicySection("Unauthorized Purchases", [
                  "If a ticket is purchased using incorrect information or unauthorized payment methods, no refund will be processed.",
                  "The ticket may also be cancelled at the discretion of the management.",
                ]),

                _buildPolicySection("Acceptance of Policy", [
                  "By completing the ticket purchase, the user confirms that they have read, understood, and accepted this Cancel & Refund Policy.",
                ]),

                const SizedBox(height: 40),

                // ---------------- IMPORTANT NOTICE BOX ----------------
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
                        "By proceeding with ticket booking, you acknowledge that you fully understand and agree to this Cancel & Refund Policy.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.orange[900],
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
  // REUSABLE POLICY SECTION (Same style as Terms Page)
  // ----------------------------------------------------------------------
  Widget _buildPolicySection(String title, List<String> points) {
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
                      style: const TextStyle(fontSize: 15, height: 1.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
