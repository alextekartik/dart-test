import 'dart:html';

import 'package:route/client.dart';

void main() {
  querySelector("#sample_text_id")
    ..text = "Click me!"
    ..onClick.listen(reverseText);

  Router router = new Router(useFragment: true);
  router.addHandler(new UrlPattern(r'/'), (_) {
    print('root');
  }); // Homepage
  router.addHandler(new UrlPattern(r'/fish/'), (_) {
    print('fish');
  }); // Fish page
  router.addHandler(new UrlPattern(r'.*'), (_) {
    print('else');
  }); // Everything else
  router.listen();
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
