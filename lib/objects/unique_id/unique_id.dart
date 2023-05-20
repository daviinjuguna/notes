import 'package:uuid/uuid.dart';

class UniqueId {
  factory UniqueId() {
    return UniqueId._(const Uuid().v1());
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(uniqueId);
  }
  const UniqueId._(this.value);
  final String value;

  @override
  String toString() {
    return 'UniqueId{value: $value}';
  }
}
