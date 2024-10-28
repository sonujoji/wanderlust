import 'package:hive/hive.dart';

part 'trip.g.dart';

@HiveType(typeId: 1)
class Trip extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late int budget;

  @HiveField(3)
  late DateTime startDate;

  @HiveField(4)
  late DateTime endDate;

  @HiveField(5)
  late int travellorCount;

  @HiveField(6)
  late int? id;

  @HiveField(7)
  late String? country;

  @HiveField(8)
  late String destinationImage;

  @HiveField(9)
  late List<String>? travellors;

  @HiveField(10)
  late bool isFavorite;

  @HiveField(11)
  late bool? isCompleted;

  @HiveField(12)
  Map<String, List<String>> iteneraries = {};

  Trip({
    this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.startDate,
    required this.endDate,
    required this.travellorCount,
    required this.country,
    required this.destinationImage,
    this.travellors,
    this.isFavorite = false,
    this.isCompleted,
    Map<String, List<String>>? iteneraries,
  }) : iteneraries = iteneraries ?? {};
}

@HiveType(typeId: 2)
class Documents extends HiveObject {
  @HiveField(0)
  final List<String> photos;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String tripId;

  Documents({required this.photos, required this.id, required this.tripId});
}
