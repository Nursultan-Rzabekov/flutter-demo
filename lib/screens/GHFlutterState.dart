import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Member.dart';
import 'package:provider/provider.dart';

import '../base_model.dart';
import 'AppDrawer.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GHFlutter());
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => GHFlutterState();
}

class GHFlutterState extends State<GHFlutter> {
  bool _progressBarActive = true;
  var _members = List<Member>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Just do it")),
      body: _progressBarActive == true
          ? new Center(child: const CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _members.length,
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) return Divider();
                final index = position ~/ 2;
                return _buildRow(index);
              }),
      drawer: AppDrawer(),
    );
  }

  Widget _buildRow(int i) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text("${_members[i].login}", style: _biggerFont),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_members[i].avatarUrl),
        ),
      ),
    ));
  }

  @override
  // ignore: missing_return
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _checkConnection();
  }

  Future<Null> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //toast("Connected");
        _loadData();
      }
    } on SocketException catch (_) {
      //toast("Not connected");
      _neverSatisfied();
    }
  }

  Future<Null> _neverSatisfied() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      // ignore: deprecated_member_use
      child: new AlertDialog(
        title: new Text('No network connection.'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('Your network connection seems to be disabled'),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Ok'),
            onPressed: () => exit(0),
          ),
        ],
      ),
    );
  }

  void _loadData() async {
    final BaseModel app = Provider.of<BaseModel>(context);
    var result = await app.networkRepository.getRequest();
    setState(() {
      _progressBarActive = false;
      _members = result;
    });
    print(result);
  }
}
