import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/language/language.dart';
import 'package:ebank_demo/pages/switch_page/mainpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login_root/root.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'alert_id', 'e_bank_demo',
    importance: Importance.high, playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMSGBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('show msg just show up :' '${message.messageId}');
}

String? notiToken;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMSGBackgroundHandler);
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  notiToken = token.toString();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? languageCode;
  @override
  void initState() {
    getData();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id, channel.name,

              // color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
              priority: Priority.high,
              importance: Importance.high,
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataUserLogins>.value(value: DataUserLogins())
        //  Provider<DataUserLogins>(create: (_) => DataUserLogins()),
      ],
      child: GetMaterialApp(
        translations: LocalString(),
        // locale: Locale('$languageCode'),
        title: 'E-Banking Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          // primaryColor: appColor,
        ),
        debugShowCheckedModeBanner: false,
        home: SwitchScreen(
          notiToken: notiToken.toString(),
        ),
        // home: const RootHomePage(),
        // home: const HomePage(),
      ),
    );
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    languageCode = pref.getString('language');
    languageCode == "en_US" ? languageCode = "1" : languageCode = "2";
    if (languageCode == "1") {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('la', 'LA'));
    }
  }
}
