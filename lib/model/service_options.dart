// lib/models/service_option.dart

class ServiceOption {
  final String category;
  final String optionName;
  final String description;
  final String price;
  final String duration;
  final String depositInfo;
  final List<String> inventory;

  ServiceOption({
    required this.category,
    required this.optionName,
    required this.description,
    required this.price,
    required this.duration,
    required this.depositInfo,
    required this.inventory,
  });
}