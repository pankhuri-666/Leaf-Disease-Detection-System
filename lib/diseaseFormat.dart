// class DiseaseResponse {
//   List<String> diseases;

//   DiseaseResponse({required this.diseases});

//   factory DiseaseResponse.fromJson(Map<String, dynamic> json) {
//     return DiseaseResponse(
//       diseases: List<String>.from(json['diseases'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['diseases'] = this.diseases;
//     return data;
//   }
// }
class DiseaseResponse {
  List<String> diseases;
  List<String> leaves;
  int severity;

  DiseaseResponse({
    required this.diseases,
    required this.leaves,
    required this.severity,
  });

  factory DiseaseResponse.fromJson(Map<String, dynamic> json) {
    return DiseaseResponse(
      diseases: List<String>.from(json['diseases'] ?? []),
      leaves: List<String>.from(json['leaves'] ?? []),
      severity: json['severity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diseases'] = this.diseases;
    data['leaves'] = this.leaves;
    data['severity'] = this.severity;
    return data;
  }
}
