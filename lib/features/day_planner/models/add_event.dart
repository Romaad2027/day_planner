import 'package:equatable/equatable.dart';

class AddEventModel extends Equatable {
  final String name;
  final String category;
  final DateTime from;
  final DateTime to;

  const AddEventModel({
    required this.name,
    required this.category,
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'from': from,
        'to': to,
      };

  @override
  List<Object?> get props => [
        name,
        category,
        from,
        to,
      ];
}
