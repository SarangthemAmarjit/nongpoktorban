class VisitorDetails {
  final String name;
  final String phone;
  final String address;
  final String email;
  final double adultCount;
  final double childCount;
  final double totalAmount;

  VisitorDetails({
    required this.adultCount,
    required this.childCount,
    required this.totalAmount,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  // Convert model to JSON (for API or Firestore)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'adultCount': adultCount,
      'childCount': childCount,
      'totalAmount': totalAmount,
    };
  }

  // Create model from JSON
  factory VisitorDetails.fromJson(Map<String, dynamic> json) {
    return VisitorDetails(
      adultCount: json['adultCount'] ?? 0,
      childCount: json['childCount'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
