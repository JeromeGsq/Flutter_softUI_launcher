import 'package:softui_launcher/core/view_model.dart';
import 'package:softui_launcher/core/widgets/event_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef ViewBuilder<T extends ViewModel> = Widget Function(
  BuildContext context,
  T viewModel,
);

Widget _buildBusy<T extends ViewModel>(BuildContext context, T viewModel) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildFail<T extends ViewModel>(BuildContext context, T viewModel) {
  return const Center(
    child: Text('Error'),
  );
}

/// A widgets that call the builder associated with the
/// view model state.
class View<T extends ViewModel> extends StatelessWidget {
  /// Creates a new [View].
  const View({
    Key key,
    ViewBuilder<T> busyBuilder,
    @required this.idleBuilder,
    ViewBuilder<T> failBuilder,
    this.onEvent,
  })  : assert(idleBuilder != null),
        busyBuilder = busyBuilder ?? _buildBusy,
        failBuilder = failBuilder ?? _buildFail,
        super(key: key);

  /// Widget builder to call when the [viewModel] has a [ViewState.busy] state.
  final ViewBuilder<T> busyBuilder;

  /// Widget builder to call when the [viewModel] has a [ViewState.idle] state.
  final ViewBuilder<T> idleBuilder;

  /// Widget builder to call when the [viewModel] has a [ViewState.fail] state.
  final ViewBuilder<T> failBuilder;

  /// Called when a new event has been dispatched.
  final void Function(BuildContext context, Object event) onEvent;

  @override
  Widget build(BuildContext context) {
    return Selector<T, ViewState>(
      selector: (BuildContext context, T viewModel) => viewModel.viewState,
      builder: (
        BuildContext context,
        ViewState viewState,
        Widget child,
      ) {
        assert(viewState != null);
        final T viewModel = Provider.of<T>(context);
        Widget widget;

        switch (viewState) {
          case ViewState.busy:
            widget = busyBuilder(context, viewModel);
            break;
          case ViewState.idle:
            widget = idleBuilder(context, viewModel);
            break;
          case ViewState.fail:
            widget = failBuilder(context, viewModel);
            break;
          default:
            widget = const SizedBox();
        }

        if (onEvent != null) {
          widget = EventListener(
            listener: onEvent,
            viewModel: viewModel,
            child: widget,
          );
        }

        return widget;
      },
    );
  }
}
