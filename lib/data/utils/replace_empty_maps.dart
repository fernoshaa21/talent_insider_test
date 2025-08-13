void replaceEmptyMaps(Map<dynamic, dynamic> jsonMap) {
  for (var key in jsonMap.keys) {
    if (jsonMap[key] is Map) {
      if (jsonMap[key].isEmpty) {
        jsonMap[key] = null;
      } else {
        replaceEmptyMaps(jsonMap[key]);
      }
    } else if (jsonMap[key] is List) {
      for (var item in jsonMap[key]) {
        if (item is Map) {
          replaceEmptyMaps(item);
        }
      }
    }
  }
}
