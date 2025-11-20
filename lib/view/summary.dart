import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torbanticketing/config/const.dart';
import 'package:torbanticketing/config/responsive.dart';
import 'package:torbanticketing/controller/managementcontroller.dart';
import 'package:torbanticketing/controller/paymentcontroller.dart';
import 'package:torbanticketing/payment/PaymentPage.dart';

class ParkTicketsPage extends StatefulWidget {
  const ParkTicketsPage({super.key});

  @override
  State<ParkTicketsPage> createState() => _ParkTicketsPageState();
}

class _ParkTicketsPageState extends State<ParkTicketsPage> {
  // Ticket counts

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Colors mapped close to the Tailwind theme in the HTML
    final primary = const Color(0xFF4CAF50);
    final backgroundLight = const Color(0xFFFCFBF8);
    final backgroundDark = const Color(0xFF102216);
    final cardLight = Colors.white;
    final cardDark = const Color(0xFF193322);
    final borderLight = const Color(0xFFE0E0E0);
    final borderDark = const Color(0xFF2a4d37);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isWide = maxWidth >= 1000;
        final pagePadding = EdgeInsets.symmetric(
          horizontal: isWide
              ? maxWidth * 0.06
              : Responsive.isMobile(context)
              ? 5
              : 16,
          vertical: 24,
        );

        return SingleChildScrollView(
          child: Padding(
            padding: pagePadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: isWide
                  ? _buildTwoColumn(
                      primary,
                      cardLight,
                      cardDark,
                      borderLight,
                      borderDark,
                    )
                  : _buildSingleColumn(
                      primary,
                      cardLight,
                      cardDark,
                      borderLight,
                      borderDark,
                    ),
            ),
          ),
        );
      },

      // simple footer
    );
  }

  Widget _buildTwoColumn(
    Color primary,
    Color cardLight,
    Color cardDark,
    Color borderLight,
    Color borderDark,
  ) {
    Managementcontroller mngcon = Get.find<Managementcontroller>();
    Paymentcontroller pngcon = Get.find<Paymentcontroller>();

    return GetBuilder<Paymentcontroller>(
      builder: (_) {
        return GetBuilder<Managementcontroller>(
          builder: (_) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Ticket selection (2/3)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Buy Your Park Tickets',
                      //   style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                      // ),
                      // const SizedBox(height: 18),
                      TicketCard(
                        icon: Icons.person,
                        title: 'Adult Pass',
                        subtitle:
                            'Ages 13-64. \nPrice: ₹${mngcon.adultrate.toStringAsFixed(2)}',
                        initialCount: mngcon.adultcount.toInt(),
                        onInc: mngcon.incAdult,
                        onDec: mngcon.decAdult,
                        primary: primary,
                        cardLight: cardLight,
                        cardDark: cardDark,
                        borderLight: borderLight,
                        borderDark: borderDark,
                      ),
                      const SizedBox(height: 12),
                      TicketCard(
                        icon: Icons.child_care,
                        title: 'Child Pass',
                        subtitle:
                            'Ages 3-12. \nPrice: ₹${mngcon.childrate.toStringAsFixed(2)}',
                        initialCount: mngcon.childcount.toInt(),
                        onInc: mngcon.incChild,
                        onDec: mngcon.decChild,
                        primary: primary,
                        cardLight: cardLight,
                        cardDark: cardDark,
                        borderLight: borderLight,
                        borderDark: borderDark,
                      ),
                      // const SizedBox(height: 12),
                      // TicketCard(
                      //   icon: Icons.elderly,
                      //   title: 'Senior Pass',
                      //   subtitle: 'Ages 65+. Price: \$25.00',
                      //   initialCount: seniorCount,
                      //   onInc: incSenior,
                      //   onDec: decSenior,
                      //   primary: primary,
                      //   cardLight: cardLight,
                      //   cardDark: cardDark,
                      //   borderLight: borderLight,
                      //   borderDark: borderDark,
                      // ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Tickets are valid for one day only. Park hours are from 9 AM to 6 PM. Visit our FAQ for more info.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 28),

                // Right: Order summary (1/3) - using fixed width
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: SizedBox(
                    width: 360,
                    child: Column(
                      children: [
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: cardLight,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Text(
                                    'Your Order',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Divider(height: 1),
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    children: [
                                      OrderRow(
                                        '${mngcon.adultcount} x Adult Pass',
                                        '₹${(mngcon.adultcount * mngcon.adultrate).toStringAsFixed(2)}',
                                      ),
                                      const SizedBox(height: 8),
                                      OrderRow(
                                        '${mngcon.childcount} x Child Pass',
                                        '₹${(mngcon.childcount * mngcon.childrate).toStringAsFixed(2)}',
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                                const Divider(height: 1),
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    children: [
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     const Text('Subtotal'),
                                      //     Text(
                                      //       '₹${mngcon.subtotal.toStringAsFixed(2)}',
                                      //       style: const TextStyle(
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(height: 8),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     const Text('Taxes & Fees'),
                                      //     Text(
                                      //       '₹${mngcon.taxesAndFees.toStringAsFixed(2)}',
                                      //       style: const TextStyle(
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '₹${mngcon.totalamount.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // mngcon
                                        //     .setfinaldetails(); // for offline ticketing
                                        // _showProceedDialog(context);
                                        // Get.find<Pagemanagementcontroller>().setPage(1);
                                        // Get.to(PayPage());

                                        if (isofflinepay) {
                                          mngcon.setfinaldetails();
                                        } else {
                                          var paymentres = await pngcon
                                              .initNdpsPayment(
                                                email: "assa@gmail.com",
                                                number: "3214234356",
                                                transId: generateRandomString(
                                                  12,
                                                ),
                                                context: context,
                                                amount: "100",
                                                address: 'fsdfsdf',
                                                name: 'amarjit',
                                                clientcodeok: '',
                                              );

                                          if (paymentres != null) {
                                            Get.to(PaymentFinalPage());
                                          } else {
                                            // context.go('/home/successpage');
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF2A9D8F,
                                        ),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          mngcon.isloading ||
                                                  pngcon.ispaymentprocessstarted
                                              ? SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                )
                                              : Text(
                                                  isofflinepay
                                                      ? 'Generate Ticket'
                                                      : "Proceed",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                          // SizedBox(width: 8),
                                          // Icon(Icons.arrow_forward, size: 20),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // FilledButton(
                                  //   onPressed: () {
                                  //     // handle payment navigation

                                  //   },
                                  //   child: const Padding(
                                  //     padding: EdgeInsets.symmetric(vertical: 12.0),
                                  //     child: Text(
                                  //       'Proceed to Payment',
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSingleColumn(
    Color primary,
    Color cardLight,
    Color cardDark,
    Color borderLight,
    Color borderDark,
  ) {
    Managementcontroller mngcon = Get.find<Managementcontroller>();
    Paymentcontroller pngcon = Get.find<Paymentcontroller>();
    return GetBuilder<Paymentcontroller>(
      builder: (_) {
        return GetBuilder<Managementcontroller>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TicketCard(
                  icon: Icons.person,
                  title: 'Adult Pass',
                  subtitle:
                      'Ages 13-64. \nPrice: ₹${mngcon.adultrate.toStringAsFixed(2)}',
                  initialCount: mngcon.adultcount.toInt(),
                  onInc: mngcon.incAdult,
                  onDec: mngcon.decAdult,
                  primary: primary,
                  cardLight: cardLight,
                  cardDark: cardDark,
                  borderLight: borderLight,
                  borderDark: borderDark,
                ),
                const SizedBox(height: 12),
                TicketCard(
                  icon: Icons.child_care,
                  title: 'Child Pass',
                  subtitle:
                      'Ages 3-12. \nPrice: ₹${mngcon.childrate.toStringAsFixed(2)}',
                  initialCount: mngcon.childcount.toInt(),
                  onInc: mngcon.incChild,
                  onDec: mngcon.decChild,
                  primary: primary,
                  cardLight: cardLight,
                  cardDark: cardDark,
                  borderLight: borderLight,
                  borderDark: borderDark,
                ),
                const SizedBox(height: 12),
                // TicketCard(
                //   icon: Icons.elderly,
                //   title: 'Senior Pass',
                //   subtitle: 'Ages 65+. Price: \$25.00',
                //   initialCount: seniorCount,
                //   onInc: incSenior,
                //   onDec: decSenior,
                //   primary: primary,
                //   cardLight: cardLight,
                //   cardDark: cardDark,
                //   borderLight: borderLight,
                //   borderDark: borderDark,
                // ),
                // const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Tickets are valid for one day only. Park hours are from 9 AM to 6 PM. Visit our FAQ for more info.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Order summary below on mobile
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cardLight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            'Your Order',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                              OrderRow(
                                '${mngcon.adultcount} x Adult Pass',
                                '₹${(mngcon.adultcount * mngcon.adultrate).toStringAsFixed(2)}',
                              ),
                              const SizedBox(height: 8),
                              OrderRow(
                                '${mngcon.childcount} x Child Pass',
                                '₹${(mngcon.childcount * mngcon.childrate).toStringAsFixed(2)}',
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     const Text('Subtotal'),
                              //     Text(
                              //       '₹${mngcon.subtotal.toStringAsFixed(2)}',
                              //       style: const TextStyle(
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 8),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     const Text('Taxes & Fees'),
                              //     Text(
                              //       '₹${mngcon.taxesAndFees.toStringAsFixed(2)}',
                              //       style: const TextStyle(
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹${mngcon.totalamount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (isofflinepay) {
                                  mngcon.setfinaldetails();
                                } else {
                                  mngcon.registerUser(
                                    clientcodeok: '',
                                    context: context,
                                    transId: mngcon.transactionid,
                                  );
                                }

                                // mngcon.setfinaldetails();
                                // Get.to(PayPage());
                                // Get.find<Pagemanagementcontroller>().setPage(1);
                                // Get.to(
                                //   () => PaymentPage(
                                //     mobile: '7005191566',
                                //     gender: '',
                                //     visitDate: DateTime(2),aa
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  mngcon.isloading ||
                                          pngcon.ispaymentprocessstarted
                                      ? SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          isofflinepay
                                              ? 'Generate Ticket'
                                              : "Proceed",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                  // SizedBox(width: 8),
                                  // Icon(Icons.arrow_forward, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/// Reusable ticket card widget with increment/decrement controls
class TicketCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int initialCount;
  final VoidCallback onInc;
  final VoidCallback onDec;
  final Color primary;
  final Color cardLight;
  final Color cardDark;
  final Color borderLight;
  final Color borderDark;

  const TicketCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.initialCount,
    required this.onInc,
    required this.onDec,
    required this.primary,
    required this.cardLight,
    required this.cardDark,
    required this.borderLight,
    required this.borderDark,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? cardDark : cardLight;
    final border = isDark ? borderDark : borderLight;

    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border),
        ),
        child: Row(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primary, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Controls
            Controls(count: initialCount, onInc: onInc, onDec: onDec),
          ],
        ),
      ),
    );
  }
}

class Controls extends StatelessWidget {
  final int count;
  final VoidCallback onInc;
  final VoidCallback onDec;
  const Controls({
    super.key,
    required this.count,
    required this.onInc,
    required this.onDec,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(36, 36),
      padding: EdgeInsets.zero,
      shape: const CircleBorder(),
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.18),
    );

    return Row(
      children: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: onDec,
          child: const Icon(Icons.remove, size: 18, color: Colors.black),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 46,
          child: Text(
            count.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: buttonStyle,
          onPressed: onInc,
          child: const Icon(Icons.add, size: 18, color: Colors.black),
        ),
      ],
    );
  }
}

class OrderRow extends StatelessWidget {
  final String left;
  final String right;
  const OrderRow(this.left, this.right, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left),
        Text(right, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
