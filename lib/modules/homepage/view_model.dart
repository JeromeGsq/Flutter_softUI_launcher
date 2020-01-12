import 'package:softui_launcher/core/view_model.dart';

class HomepageViewModel extends ViewModel {
  HomepageViewModel() : super(viewState: ViewState.busy);

  Future<void> load() async {
    idle();
  }
}
