import 'package:homecook/services/networkhandler.dart';

class MaindishesService {
  String URL = 'maindish/';
  networkhandler Networkhandler = networkhandler();
  Future addmaindish(Map<String, dynamic> data) async {
    return await Networkhandler.post(URL, data);
  }

  Future getdishes() async {
    return await Networkhandler.get(URL);
  }

  Future getdishesforcooker(id) async {
    return await Networkhandler.get(URL + 'cooker/' + id);
  }

  Future getdishe(id) async {
    return await Networkhandler.get(URL + id);
  }
}
