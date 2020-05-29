@JS()
library react_render_fixes;

import 'dart:html';

import 'package:js/js.dart';

@JS('ReactDOM.render')
external dynamic reactdomRender(dynamic toRender, Node whatever);

@JS('Function')
external Function(Node, Function(Node)) JSFunction(
    String arg0, String arg1, String body);

Function(Node, Function(Node)) addShadowRoot =
    JSFunction('hostDiv', 'render', '''
      const shadow = hostDiv.attachShadow({ mode: 'open' });
      this.mountPoint = document.createElement('div');
      shadow.appendChild(this.mountPoint);
      Object.defineProperty(this.mountPoint, 'ownerDocument', { value: shadow });
      shadow.createElement =  function(one, two) { return document.createElement(...arguments); };
      shadow.createElementNS = function(one, two, three) { return document.createElementNS(...arguments); };
      shadow.createTextNode = function(one) { return document.createTextNode(...arguments); };
      render(this.mountPoint);
''');
