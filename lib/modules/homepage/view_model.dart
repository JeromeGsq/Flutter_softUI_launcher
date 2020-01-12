import 'package:softui_launcher/core/view_model.dart';

class HomepageViewModel extends ViewModel {
  HomepageViewModel() : super(viewState: ViewState.busy);

  String title;
  int count;

  Future<void> load() async {
    title = 'Hello';
    count = 0;
    idle();
  }

  Future<void> add() async {
    count++;
    notifyListeners();
    idle();
  }
}
