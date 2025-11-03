import 'package:uuid/uuid.dart';

String uniqueIdRacikanGenerator() {
  var uuid = Uuid();

  String id = uuid.v4();

  return id;
}