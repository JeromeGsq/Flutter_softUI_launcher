import 'dart:async';

import 'package:flutter/material.dart';
import 'package:softui_launcher/core/view_model.dart';

/// A widget that listens to events dispateched by a view model.
@immutable
class EventListener extends StatefulWidget {
  /// Creates a new [EventListener] which listens to the [viewModel.events] stream
  /// and calls [listener] each time a new event is dispatched.
  const EventListener({
    Key key,
    @required this.child,
    @required this.viewModel,
    @required this.listener,
  }) : super(key: key);

  /// The widget that is below the current [EventListener] widget in the
  /// tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The view model which this [EventListener] listens to.
  final ViewModel viewModel;

  /// The function called on every [event] dispatched by the [viewModel].
  /// That listener should be used for navigating or showing a dialog.
  final void Function(BuildContext context, Object event) listener;

  @override
  _EventListenerState createState() => _EventListenerState();
}

class _EventListenerState extends State<EventListener> {
  StreamSubscription<Object> _subscription;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(EventListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != widget.viewModel) {
      if (_subscription != null) {
        _unsubscribe();
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (widget.viewModel != null) {
      _subscription = widget.viewModel.events.listen((Object event) {
        widget.listener.call(context, event);
      });
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }
}
