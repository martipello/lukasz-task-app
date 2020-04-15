import 'package:flutter/widgets.dart';

T get<T>(BuildContext context) {
  return ServiceLocator.of(context).get(context);
}

abstract class _ServiceLocator {
  T get<T>(BuildContext context);
}

class ServiceLocator extends StatefulWidget {
  const ServiceLocator({
    Key key,
    @required this.dependencies,
    @required this.child,
  }) : super(key: key);

  final Set<Object> Function() dependencies;
  final Widget child;

  static _ServiceLocator of(BuildContext context) {
    return context.findAncestorStateOfType<_ServiceLocatorState>();
  }

  @override
  _ServiceLocatorState createState() => _ServiceLocatorState();
}

class _ServiceLocatorState extends State<ServiceLocator>
    implements _ServiceLocator {
  Set<Object> _dependencies;

  Set<Object> get dependencies {
    return _dependencies ??= widget.dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  T get<T>(BuildContext context) {
    return dependencies.firstWhere((d) => d is T);
  }
}
