List<String> convertListDynamicToListString(List<dynamic> data) {
  List<String> newList = [];
  for (int i = 0; i < data.length; i++) {
    newList.add(data[i].toString());
  }
  return newList;
}

List<List<String>> convertListDynamicToListListString(List<dynamic> data) {
  List<List<String>> newList = [];
  for (int i = 0; i < data.length; i++) {
    newList.add(List<String>.from(data[i] as List));
  }
  return newList;
}
