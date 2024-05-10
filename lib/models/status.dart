class Status {
  final int id;
  final String status;
  final DateTime timestamp;

  Status({required this.status, required this.id, required this.timestamp});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp'])
    );
  }
}
