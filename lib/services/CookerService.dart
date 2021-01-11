import 'package:homecook/ratecooker.dart';
import 'package:homecook/services/networkhandler.dart';

class CookerService {
  String URL = 'cookers/';
  networkhandler Networkhandler = networkhandler();
  Future signin(Map<String, dynamic> data) async {
    return await Networkhandler.newpost(URL, data);
  }

  login(data) async {
    return await Networkhandler.newpost('logincooker', data);
  }

  getcooker() async {
    return await Networkhandler.get(URL + 'one');
  }

  setstate(data) async {
    return await Networkhandler.put(URL, data);
  }

  getcookerwithid(id) async {
    return await Networkhandler.get(URL + 'withid/' + id);
  }

  getseconddishes() async {
    return await Networkhandler.get('');
  }

  getcookers() async {
    return await Networkhandler.get(URL);
  }

  askingforcooker(data) async {
    return await Networkhandler.put('askingforcooker/response', data);
  }

  getaskingforcooker(id) async {
    return await Networkhandler.get('askingforcooker/response/' + id);
  }

  refreshtoken(Map<String, dynamic> data) async {
    return await Networkhandler.put(URL, data);
  }

  getsubscriptions() async {
    return await Networkhandler.get('subscription/cooker');
  }

  getsubscriptionsone(id) async {
    return await Networkhandler.get('subscription/' + id);
  }

  ratecooker(data) async {
    return await Networkhandler.put('subscription', data);
  }

  getimages() async {
    return await Networkhandler.get('images');
  }
}
