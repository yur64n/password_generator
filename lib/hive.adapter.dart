import 'package:hive/hive.dart';

part 'hive.adapter.g.dart';

@HiveType(typeId: 0)
class SavedPassword extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String password;

  SavedPassword({required this.name, required this.password});
}