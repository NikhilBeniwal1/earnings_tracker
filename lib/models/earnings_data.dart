class EarningsData {
  final String pricedate;
  final String ticker; // Make sure this is defined
  final double actualEps;
  final double estimatedEps;
  final double actualRevenue;
  final double estimatedRevenue;

  EarningsData({
    required this.pricedate,
    required this.ticker,
    required this.actualEps,
    required this.estimatedEps,
    required this.actualRevenue,
    required this.estimatedRevenue,
  });

  // Factory constructor to create EarningsData from JSON, if needed
  factory EarningsData.fromJson(Map<String, dynamic> json) {
    return EarningsData(
      pricedate: json['pricedate'] ?? '',
      ticker:  json['ticker'],
      actualEps: (json['actual_eps'] ?? 0.0).toDouble(),
      estimatedEps: (json['estimated_eps'] ?? 0.0).toDouble(),
      actualRevenue: (json['actual_revenue'] ?? 0.0).toDouble(),
      estimatedRevenue: (json['estimated_revenue'] ?? 0.0).toDouble(),
    );
  }
}

class EarningsTranscript {
  final String transcript;

  EarningsTranscript({required this.transcript});

  factory EarningsTranscript.fromJson(Map<String, dynamic> json) {
    return EarningsTranscript(
      transcript: json['transcript'] ?? 'Transcript not available',
    );
  }
}
