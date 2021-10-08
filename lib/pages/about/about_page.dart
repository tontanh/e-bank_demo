import 'package:ebank_demo/pages/constant/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('ABOUT'.tr),
        centerTitle: true,
      ),
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'This Application Create By: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Mr Tontanh Keomanyvong'),
          Text(
            'Contact Me',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Email : tonkmnv@gmail.com'),
          Text(
            'Font-End : Flutter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Back-End : Node Js',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Database : Mysql',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
