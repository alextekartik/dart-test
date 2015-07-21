import 'dart:html';

void main() {
  window.indexedDB.getDatabaseNames().then((List<String> names) {
    UListElement ul = document.body.querySelector('#databases');
    for (String name in names) {
      ul.append(new LIElement()..text = name);
    }
    document.body.querySelector('#database_count').text = "${names.length} databases found";
  });
}
