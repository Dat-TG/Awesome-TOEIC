import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/home_page.dart';
import 'package:toeic_app/settings/language_form.dart';
import 'package:toeic_app/settings/remind_dialog.dart';
import 'package:toeic_app/sign_in.dart';
import 'package:toeic_app/sign_up.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

import 'others/get_It.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String photoURL = 'assets/img/default_avatar.png';
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTheme();
    print("photoURL $photoURL");
    print("user $user");
  }

  final List<String> entries = <String>[
    'Đăng nhập | Đăng ký',
    'Bí quyết sử dụng ứng dụng hiệu quả',
    'Ngôn ngữ',
    'Giao diện tối',
    'Giao diện đáp án',
    'Facebook Page',
    'Chia sẻ ứng dụng',
    'Quản lý tải xuống',
    'Nhắc nhở học tập',
    'Phản hồi về ứng dụng',
    'Đánh giá ứng dụng',
    'Hướng dẫn sử dụng',
    'Điều khoản và chính sách',
    'Phiên bản'
  ];
  final List<IconData> icons = <IconData>[
    Icons.login,
    Icons.book,
    Icons.language,
    Icons.dark_mode,
    Icons.view_agenda,
    Icons.facebook,
    Icons.share,
    Icons.download,
    Icons.alarm,
    Icons.question_answer,
    Icons.star,
    Icons.book,
    Icons.list,
    Icons.type_specimen
  ];
  String version = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 50,
          child: Container(
            alignment: Alignment.centerLeft,
            child: (entries.elementAt(index) != 'Giao diện tối')
                ? ListTile(
                    leading: (index > 0)
                        ? Icon(
                            icons.elementAt(index),
                            color: colorApp,
                          )
                        : (user != null)
                            ? (photoURL == 'assets/img/default_avatar.png')
                                ? Image.asset(photoURL)
                                : CircleAvatar(
                                    backgroundColor: colorApp,
                                    radius: 20,
                                    child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(photoURL)))
                            : Icon(
                                icons.elementAt(index),
                                color: colorApp,
                              ),
                    title: index > 0
                        ? Text(
                            entries.elementAt(index),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          )
                        : (user == null)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignIn()));
                                      },
                                      style: TextButton.styleFrom(
                                          padding:
                                              const EdgeInsets.only(left: 0)),
                                      child: const Text(
                                        'Đăng nhập',
                                        style: TextStyle(
                                            color: colorApp,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ),
                                    const Text(' | '),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUp()));
                                      },
                                      style: TextButton.styleFrom(
                                          padding:
                                              const EdgeInsets.only(left: 0)),
                                      child: const Text(
                                        'Đăng ký',
                                        style: TextStyle(
                                            color: colorApp,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    )
                                  ])
                            : Text(
                                (user != null)
                                    ? (user!.displayName != null)
                                        ? user!.displayName!
                                        : ""
                                    : "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: colorApp),
                              ),
                    // ignore: avoid_print
                    onTap: () => {
                      if (entries.elementAt(index) == "Ngôn ngữ")
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Wrap(children: [
                                  AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Text(
                                        "Chọn ngôn ngữ",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      content:
                                          const Center(child: LanguageForm())),
                                ]),
                              );
                            },
                          )
                        }
                      else if (entries.elementAt(index) == "Chia sẻ ứng dụng")
                        {Share.share('Link apk hoặc CH Play')}
                      else if (entries.elementAt(index) == "Nhắc nhở học tập")
                        {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return RemindDialog();
                            },
                          )
                        }
                    },
                    trailing: (entries.elementAt(index) == "Phiên bản" ||
                            entries.elementAt(index) == "Ngôn ngữ")
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              (entries.elementAt(index) == "Phiên bản")
                                  ? Text(
                                      version,
                                      style:
                                          TextStyle(color: Colors.orange[500]),
                                    )
                                  : Text(language,
                                      style:
                                          TextStyle(color: Colors.orange[500]))
                            ],
                          )
                        : (index == 0 && user != null)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      await GoogleSignIn().signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    intialIndex: 4,
                                                  )));
                                    },
                                    child: Text(
                                      "Đăng xuất",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: orange,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              )
                            : Column(),
                  )
                : SwitchListTile(
                    value: isDarkMode,
                    title: Text(
                      entries.elementAt(index),
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    secondary: Icon(
                      icons.elementAt(index),
                      color: colorApp,
                    ),
                    onChanged: (bool value) => setState(() {
                          isDarkMode = value;
                          // Set color box

                          _changeTheme();
                          if (isDarkMode) {
                            MyApp.of(context).changeTheme(ThemeMode.dark);
                          } else {
                            MyApp.of(context).changeTheme(ThemeMode.light);
                          }
                        })),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Future<void> _loadTheme() async {
    final prefs = locator<SharedPreferences>();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
      isRemind = (prefs.getBool('isRemind') ?? false);
      timeRemind =
          (prefs.getString("TimeRemind") ?? TimeOfDay.now().format(context));
      changeColorByTheme();
      language = (prefs.getString("language") ?? "Language.vietnamese");
      switch (language) {
        case "Language.vietnamese":
          language = "Tiếng Việt";
          enumLanguage = Language.vietnamese;
          break;
        case "Language.english":
          language = "English";
          enumLanguage = Language.english;
          break;
        case "Language.french":
          language = "Français";
          enumLanguage = Language.french;
          break;
        case "Language.russian":
          language = "Русский";
          enumLanguage = Language.russian;
          break;
        case "Language.chinese":
          language = "中文";
          enumLanguage = Language.chinese;
          break;
        case "Language.spanish":
          language = "Español";
          enumLanguage = Language.spanish;
          break;
        default:
          break;
      }
      user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user!.photoURL != null) photoURL = user!.photoURL!;
      }
    });
  }

  //Incrementing counter after click
  void _changeTheme() async {
    final prefs = locator<SharedPreferences>();
    setState(() {
      prefs.setBool('DarkMode', isDarkMode);
      changeColorByTheme();
    });
  }
}

Future<TimeOfDay?> showTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  TransitionBuilder? builder,
  bool useRootNavigator = true,
  TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  String? cancelText,
  String? confirmText,
  String? helpText,
  String? errorInvalidText,
  String? hourLabelText,
  String? minuteLabelText,
  RouteSettings? routeSettings,
  EntryModeChangeCallback? onEntryModeChanged,
  Offset? anchorPoint,
}) async {
  assert(debugCheckHasMaterialLocalizations(context));

  final Widget dialog = TimePickerDialog(
    initialTime: initialTime,
    initialEntryMode: initialEntryMode,
    cancelText: cancelText,
    confirmText: confirmText,
    helpText: helpText,
    errorInvalidText: errorInvalidText,
    hourLabelText: hourLabelText,
    minuteLabelText: minuteLabelText,
    onEntryModeChanged: onEntryModeChanged,
  );
  return showDialog<TimeOfDay>(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}
