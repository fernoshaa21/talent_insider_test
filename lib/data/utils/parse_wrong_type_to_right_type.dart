String? toStringOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is String) return value;
    return value.toString();
  } catch (_) {
    return null;
  }
}

int? toIntOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is int) return value;
    if (value is String) return int.parse(value);
    if (value is double) return value.toInt();
    return int.parse(value.toString());
  } catch (_) {
    return null;
  }
}

double? toDoubleOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.parse(value);
    return double.parse(value.toString());
  } catch (_) {
    return null;
  }
}

bool? toBoolOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is bool) return value;
    if (value is String) {
      final lowercaseValue = value.toLowerCase();
      if (lowercaseValue == 'true') return true;
      if (lowercaseValue == 'false') return false;
    }
    if (value is num) return value != 0;
    return null;
  } catch (_) {
    return null;
  }
}

List? toListOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is List) return value;

    return null;
  } catch (_) {
    return null;
  }
}

Map<String, dynamic>? toMapOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  } catch (_) {
    return null;
  }
}

DateTime? toDateTimeOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.parse(value);
    }
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return null;
  } catch (_) {
    return null;
  }
}

// New function for Duration
Duration? toDurationOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is Duration) return value;
    if (value is int) return Duration(milliseconds: value);
    if (value is String) {
      final parts = value.split(':');
      if (parts.length == 3) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final seconds = int.parse(parts[2]);
        return Duration(hours: hours, minutes: minutes, seconds: seconds);
      }
    }
    return null;
  } catch (_) {
    return null;
  }
}

// New function for Uri
Uri? toUriOrNull(dynamic value) {
  if (value == null) return null;
  try {
    if (value is Uri) return value;
    if (value is String) return Uri.parse(value);
    return null;
  } catch (_) {
    return null;
  }
}

dynamic wrongTypeToDynamic(dynamic value) {
  return value;
}

// int _intOrNum(dynamic value) {
//   if (value is int) {
//     return value; // Jika sudah int, kembalikan langsung
//   } else if (value is num) {
//     return value.toInt(); // Jika num, konversi ke int
//   }
//   return 0; // Kembalikan 0 jika tidak ada nilai yang valid
// }
