class Stimulus {
  final int id;
  final String type;
  final int value;
  final String? reason;

  Stimulus({
    required this.id,
    required this.type,
    required this.value,
    this.reason,
  });

  factory Stimulus.fromJson(Map<String, dynamic> json) {
    return Stimulus(
      id: json['id'] as int,
      type: json['type'] as String,
      value: json['value'] as int,
      reason: json['reason'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'reason': reason,
    };
  }
}
