import 'package:homecook/services/networkhandler.dart';

class UserService {
  String URL = 'users/';
  networkhandler Networkhandler = networkhandler();
  Future signin(Map<String, dynamic> data) async {
    return await Networkhandler.post(URL, data);
  }

  login(data) async {
    return await Networkhandler.post('loginuser', data);
  }

  getusers() async {
    return await Networkhandler.get(URL);
  }

  askingforcooker(data) async {
    return await Networkhandler.post('askingforcooker', data);
  }

  getaskingforcooker(id) async {
    return await Networkhandler.get('askingforcooker/' + id);
  }

  getuser() async {
    return await Networkhandler.get(URL + 'one');
  }

  getseconddishes() async {
    return await Networkhandler.get('');
  }

  refreshtoken(Map<String, dynamic> data) async {
    return await Networkhandler.put(URL, data);
  }

  createsubscription(data) async {
    return await Networkhandler.post('subscription', data);
  }

  getsubscriptions() async {
    return await Networkhandler.get('subscription/user');
  }
}
