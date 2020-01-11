import 'package:launcher_assist/launcher_assist.dart';
import 'package:softui_launcher/core/view_model.dart';

class HomeViewModel extends ViewModel {
  HomeViewModel() : super(viewState: ViewState.busy);

  String title;

  List<dynamic> apps;
  List<dynamic> favoritesApps;

  bool isCurrentAppFavorite = false;
  int currentPage = 0;

  Future<void> load() async {
    apps = [];
    favoritesApps = [];
    currentPage = 0;

    apps = await LauncherAssist.getAllApps();

    idle();
  }

  onPageChanged({int index}) {
    currentPage = index;
    isCurrentAppFavorite = favoritesApps.contains(apps[currentPage]);

    notifyListeners();
  }

  addFavorite({dynamic app}) {
    if (favoritesApps.contains(app)) {
      favoritesApps.remove(app);
    } else {
      favoritesApps.add(app);
    }
    isCurrentAppFavorite = favoritesApps.contains(apps[currentPage]);

    notifyListeners();
  }
}
