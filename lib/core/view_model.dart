import 'dart:async';

import 'package:flutter/foundation.dart';

/// The different states of the view.
enum ViewState {
  /// When data is being loaded.
  busy,

  /// When data has been loaded and we waiting for user input.
  idle,

  /// When there has been an error while loading the data.
  fail,
}

/// The base class for view models.
abstract class ViewModel extends ChangeNotifier {
  /// Creates a new view model.
  ViewModel({
    ViewState viewState = ViewState.idle,
  })  : assert(viewState != null),
        _viewState = viewState,
        _streamController = StreamController.broadcast();

  final StreamController<Object> _streamController;
  Stream<Object> get events => _streamController.stream;

  /// The state of the view.
  ViewState get viewState => _viewState;
  ViewState _viewState = ViewState.idle;
  @protected
  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  /// Sets the [ViewState.busy] state.
  @protected
  void busy() => viewState = ViewState.busy;

  /// Sets the [ViewState.idle] state.
  @protected
  void idle() => viewState = ViewState.idle;

  /// Sets the [ViewState.fail] state.
  @protected
  void fail() => viewState = ViewState.fail;

  /// Loads data and manage the state of the view.
  @protected
  Future<void> loadData(
    Future<void> Function() dataLoader, {
    void Function(dynamic error) onError,
  }) async {
    busy();
    try {
      await dataLoader();
      idle();
    } catch (error) {
      _viewState = ViewState.fail;
      if (onError != null) {
        onError(error);
      }
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    _streamController?.close();
    super.dispose();
  }

  void dispatch(Object event) {
    _streamController.sink.add(event);
  }
}
