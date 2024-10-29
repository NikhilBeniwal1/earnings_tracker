class EarningsData {
  final String pricedate;
  final double actualEps;
  final double estimatedEps;
  final double actualRevenue;
  final double estimatedRevenue;

  EarningsData({
    required this.pricedate,
    required this.actualEps,
    required this.estimatedEps,
    required this.actualRevenue,
    required this.estimatedRevenue,
  });

  // Factory constructor to create EarningsData from JSON, if needed
  factory EarningsData.fromJson(Map<String, dynamic> json) {
    return EarningsData(
      pricedate: json['pricedate'] ?? '',
      actualEps: (json['actual_eps'] ?? 0.0).toDouble(),
      estimatedEps: (json['estimated_eps'] ?? 0.0).toDouble(),
      actualRevenue: (json['actual_revenue'] ?? 0.0).toDouble(),
      estimatedRevenue: (json['estimated_revenue'] ?? 0.0).toDouble(),
    );
  }
}
