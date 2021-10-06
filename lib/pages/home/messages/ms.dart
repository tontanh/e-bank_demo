import 'package:ebank_demo/pages/constant/data.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MESSAGE'),
        backgroundColor: appColor,
        actions: [Icon(Icons.replay_outlined)],
      ),
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          showList(
            text3: 'TRO',
            title: 'Fund tranfer sent',
            cardText: 'NBB Classic Card 5555 5555 xxx xxxx',
            accountText: 'To account : TONTANH KEOMANYVONG',
            detailText: 'DISCRIPTION : borrow',
            moneyText: '-200,000 kip',
            color: Colors.red,
          ),
          showList(
            text3: 'TRI',
            title: 'Fund tranfer received',
            cardText: 'NBB Classic Card 5555 5555 xxx xxxx',
            accountText: 'Form account : MEME KEOMANYVONG',
            detailText: 'DISCRIPTION : borrow',
            moneyText: '200,000 kip',
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  showList(
      {String? text3,
      title,
      cardText,
      accountText,
      detailText,
      moneyText,
      Color? color}) {
    return Container(
      height: 120,
      color: Colors.grey[100],
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          '$text3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '$cardText',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '$accountText',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '$detailText',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '$moneyText',
                        style: TextStyle(fontSize: 18, color: color),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
