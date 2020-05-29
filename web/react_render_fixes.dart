@JS()
library react_render_fixes;

import 'dart:html';

import 'package:js/js.dart';

@JS('ReactDOM.render')
external dynamic reactdomRender(dynamic element, Node mountNode);

@JS('Function')
external Function(Node, Function(Node)) JSFunction(
    String arg0, String arg1, String body);

Function(Node, Function(Node)) addShadowRoot =
    JSFunction('hostDiv', 'render', '''
      const shadow = hostDiv.attachShadow({ mode: 'open' });
      this.mountPoint = document.createElement('div');
      function changeOwnerDocumentToShadowRoot(element, appContainer) {
          Object.defineProperty(element, 'ownerDocument', {value: appContainer});
      }
      function augmentAppendChildWithOwnerDocument(elem, appContainer) {
        const origAppChild = elem.appendChild;
        const propDesc = Object.getOwnPropertyDescriptor(elem, 'appendChild');
        if (!propDesc || propDesc.writable) {
            Object.defineProperty(elem, 'appendChild', {
                value: function(child) {
                    changeOwnerDocumentToShadowRoot(child, appContainer);
                    origAppChild?.call(elem, child);
                }
            });
        }
      }
      augmentAppendChildWithOwnerDocument(this.mountPoint, shadow);
      shadow.appendChild(this.mountPoint);
      Object.defineProperty(this.mountPoint, 'ownerDocument', { value: shadow });
      shadow.createElement =  function(one, two) { return document.createElement(...arguments); };
      shadow.createElementNS = function(one, two, three) { return document.createElementNS(...arguments); };
      shadow.createTextNode = function(one) { return document.createTextNode(...arguments); };
      render(this.mountPoint);
''');
