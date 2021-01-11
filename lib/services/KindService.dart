import 'package:homecook/services/networkhandler.dart';

class KindService {
  String URL = 'kind';
  networkhandler Networkhandler = networkhandler();
  Future addKind(Map<String, dynamic> data) async {
    return await Networkhandler.post(URL, data);
  }

  Future getKind() async {
    return await Networkhandler.get(URL);
  }
}
