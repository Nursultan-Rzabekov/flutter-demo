import 'package:flutter/widgets.dart';
import 'package:flutter_demo/NetworkApi.dart';

class BaseModel extends ChangeNotifier {
  BaseModel(this._networkRepository);

  final NetworkAPI _networkRepository;
  //final Storage _storage;

  NetworkAPI get networkRepository => _networkRepository;

  //Storage get storage => _storage;

  void refresh() {
    notifyListeners();
  }
}
