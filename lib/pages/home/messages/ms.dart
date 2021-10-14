import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/root_page/controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<MessagePage> {
  StreamController? _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int count = 1;
  final getData = Get.put(PageNextCard());
  Future fetchPost([howMany = 5]) async {
    String ac_no = getData.ac_no.toString();
    String token = getData.token.toString();

    var url = Uri.parse(apiHisTransfer);
    var body = json.encode({"trans_reciever": ac_no, "trans_sender": ac_no});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  loadPosts() async {
    fetchPost().then((res) async {
      _postsController?.add(res);
      return res;
    });
  }

  showSnack() {
    // ignore: deprecated_member_use
    return scaffoldKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  // ignore: prefer_void_to_null
  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    fetchPost(count * 5).then((res) async {
      _postsController?.add(res);
      showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _postsController = StreamController();
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        backgroundColor: appColor,
        centerTitle: true,
        title: Text('MESSAGES'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: _handleRefresh,
          )
        ],
      ),
      body: StreamBuilder(
        stream: _postsController?.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // print('Has error: ${snapshot.hasError}');
          // print('Has data: ${snapshot.hasData}');
          // print('Snapshot Data ${snapshot.data}');
          String checkPlease = snapshot.data.toString();

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            if (checkPlease == '[]' ||
                checkPlease == 'null' ||
                checkPlease == null) {
              return Center(child: Text('No Posts'));
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          // print("=======" + snapshot.data.toString());
                          var post = snapshot.data[index];
                          return ListTile(
                            title: Text(post['trans_detail']),
                            subtitle: Text(post['trans_sender']),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            // ignore: prefer_const_constructors
            return Center(
              // ignore: prefer_const_constructors
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Center(child: Text('No Posts'));
          }

          return const Center(
            // ignore: prefer_const_constructors
            child: CircularProgressIndicator(),
          );
        },
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                                style: const TextStyle(
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
          ),
        ],
      ),
    );
  }
}
