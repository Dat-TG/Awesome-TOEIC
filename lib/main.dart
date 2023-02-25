import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toeic_app/api/add_question.dart';
import 'package:toeic_app/api/data.dart';

import 'home_page.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:typed_data/typed_data.dart";
import 'others/get_It.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await initNotification();
  await showRemindNotification();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const String _title = 'TOEIC APP';

  @override
  State<MyApp> createState() => _MyAppState();
  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int start = 0;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    // importData(); // Import data
  }

  //
  Future<void> importData() async {
    var documents = await firestore.collection("Answers").get();
    setState(() {
      start = documents.size;
    });
    for (int i = 0; i < 6; i++) {
      await addQuestion(qID[i], listQuestion[i], listAnswers[i],
          listRightAnswer[i], partID[i], start,
          imagesURL: [imagesURL[0][i]], audioURL: audio[i], examID: examID);
      documents = await firestore.collection("Answers").get();
      setState(() {
        start = documents.size;
      });
    }

    for (int i = 6; i < 31; i++) {
      await addQuestion(qID[i], listQuestion[i], listAnswers[i],
          listRightAnswer[i], partID[i], start,
          audioURL: audio[i], examID: examID);
      documents = await firestore.collection("Answers").get();
      setState(() {
        start = documents.size;
      });
    }

    for (int i = 31; i < 54; i++) {
      await addQuestion(qID[i], listQuestion[i], listAnswers[i],
          listRightAnswer[i], partID[i], start,
          audioURL: audio[i],
          examID: examID,
          imagesURL: [imagesURL[1][i - 31]]);
      documents = await firestore.collection("Answers").get();
      setState(() {
        start = documents.size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
      changeColorByTheme();
    });
  }

  Future<void> _loadTheme() async {
    final prefs = locator<SharedPreferences>();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
      isRemind = (prefs.getBool('isRemind') ?? false);
      if (isDarkMode) {
        _themeMode = ThemeMode.dark;
      }
      changeColorByTheme();
    });
  }
}

tz.TZDateTime _nextInstanceOfRemindTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute, 0);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(hours: 24));
  }
  print(scheduledDate);
  return scheduledDate;
}

Future<void> showRemindNotification() async {
  if (!isRemind) {
    await flutterLocalNotificationsPlugin.cancel(0);
    return;
  }
  tz.initializeTimeZones();
  final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZone));

  final prefs = locator<SharedPreferences>();
  String timeRemindString = prefs.getString("TimeRemind") ?? "12:00 AM";
  int hour = int.parse(timeRemindString.split(":")[0]);
  int minute = int.parse(timeRemindString.split(":")[1].substring(0, 2));
  if (timeRemindString.substring(timeRemindString.length - 2) == "PM" &&
      hour != 12) {
    hour += 12;
  }
  if (timeRemindString.substring(timeRemindString.length - 2) == "AM" &&
      hour == 12) {
    hour = 0;
  }

  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Đã đến giờ học rồi',
      'Vào app luyện thôi bạn ơi',
      _nextInstanceOfRemindTime(hour, minute),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        styleInformation: BigTextStyleInformation(''),
      )),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> initNotification() async {
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  const InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsIOS,
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> getQuestion(List<Map<String, dynamic>> data, int partID) async {
  var temp;
  await FirebaseFirestore.instance
      .collection("Questions")
      .where('part_id', isEqualTo: 6)
      .get()
      .then((value) async => {
            for (int i = 0; i < value.docs.length; i++)
              {
                temp = value.docs[i].data(),
                temp['list_answers'] = [],
                data.add(temp),
                for (int j = 0; j < temp['list_answers_id'].length; j++)
                  {
                    await FirebaseFirestore.instance
                        .collection("Answers")
                        .where(FieldPath.documentId,
                            isEqualTo: temp['list_answers_id'][j])
                        .get()
                        .then((value) => {
                              temp['list_answers']
                                  .add(value.docs[0].data()['list_answers']),
                              //print("answer ${temp['list_answers'][j]}")
                            })
                  }
              },
            print(value.docs.length)
          });
  print("get questions");
}
