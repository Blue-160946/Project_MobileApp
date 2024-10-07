class Transactions {
  final int? keyID;
  final String region;
  final String champion;
  final String role;
  final DateTime date;

  Transactions({
    this.keyID,
    required this.region,
    required this.champion,
    required this.role,
    required this.date,
  });
}