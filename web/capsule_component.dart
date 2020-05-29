import 'dart:html';

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';

import 'react_render_fixes.dart';

// ignore: uri_has_not_been_generated
part 'capsule_component.over_react.g.dart';

// ignore: undefined_identifier, non_constant_identifier_names
UiFactory<CapsuleProps> Capsule = _$Capsule;

mixin CapsuleProps on UiProps {
  bool attachShadow;
  void Function(Node node) didMountCallback;
}

class CapsuleComponent extends UiComponent2<CapsuleProps> {
  final Ref<DivElement> _divRef = createRef();

  @override
  bool shouldComponentUpdate(Map nextProps, Map nextState) => false;

  @override
  Map get defaultProps {
    return newProps()..attachShadow = true;
  }

  @override
  void componentDidMount() {
    super.componentDidMount();
    if (props.didMountCallback != null) {
      if (props.attachShadow) {
        addShadowRoot(_divRef.current, allowInterop(props.didMountCallback));
      } else {
        props.didMountCallback(_divRef.current);
      }
    }
  }

  @override
  dynamic render() {
    return (Dom.div()
      ..className = 'capsule-host'
      ..ref = _divRef
      ..style = {
        'margin': '5px',
        'padding': '5px',
        'border': props.attachShadow ? 'solid 2px red' : 'dotted 2px green'
      })();
  }
}
