import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('test'),
            Text('${userAcccess.uIdGet}'),
            Text('${userAcccess.jwtGet}'),
          ],
        ),
      ),
    );
  }
}
