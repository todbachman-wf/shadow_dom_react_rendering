import 'dart:html';

import 'package:over_react/over_react.dart';

import 'react_render_fixes.dart';
import 'capsule_component.dart';

void main() {
  setClientConfiguration();
  var host = querySelector('#output');
  reactdomRender((Capsule()..didMountCallback = renderFoo)(), host);
}

void renderFoo(Node node) {
  reactdomRender(
      Dom.div()(
        renderButton('Foo'),
        (Capsule()
          ..attachShadow = false
          ..didMountCallback = renderDirectly('Bar'))(),
        (Capsule()
          ..attachShadow = false
          ..didMountCallback = renderIndirectly('Fizz'))(),
        (Capsule()..didMountCallback = renderDirectly('Buzz'))(),
        (Capsule()..didMountCallback = renderIndirectly('Bazz'))(),
      ),
      node);
}

void Function(Node node) renderIndirectly(String buttonName) => (Node node) {
      var host = DivElement();
      node.append(host);
      reactdomRender(renderButton(buttonName), host);
    };

void Function(Node node) renderDirectly(String buttonName) => (Node node) {
      reactdomRender(renderButton(buttonName), node);
    };

ReactElement renderButton(String buttonName) =>
    (Dom.button()..onClick = (_) => print('$buttonName clicked'))(buttonName);
