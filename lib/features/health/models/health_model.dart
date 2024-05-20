class HealthModel {
  final int? steps;
  final int? heartRate;
  final int? bloodPressure;

  const HealthModel({
    this.steps,
    this.bloodPressure,
    this.heartRate,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) {
    return HealthModel(
      steps: json['steps'],
      heartRate: json['heartRate'],
      bloodPressure: json['bloodPressure'],
    );
  }

  Map<String, dynamic> toJson() => {
        'steps': steps,
        'heart_rate': heartRate,
        'blood_pressure': bloodPressure,
      };
}
