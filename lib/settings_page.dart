import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/sign_in.dart';
import 'package:toeic_app/sign_up.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTheme();
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
                    leading: Icon(
                      icons.elementAt(index),
                      color: colorApp,
                    ),
                    title: index > 0
                        ? Text(
                            entries.elementAt(index),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()));
                                  },
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(left: 0)),
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
                                            builder: (context) => SignUp()));
                                  },
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(left: 0)),
                                  child: const Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                        color: colorApp,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                )
                              ]),
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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
    });
  }

  //Incrementing counter after click
  void _changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('DarkMode', isDarkMode);
      changeColorByTheme();
    });
  }
}

//Select Language Popup Form

enum Language { english, vietnamese, french, spanish, chinese, russian }

class LanguageForm extends StatefulWidget {
  const LanguageForm({super.key});

  @override
  State<LanguageForm> createState() => _LanguageFormState();
}

class _LanguageFormState extends State<LanguageForm> {
  Language? _language = enumLanguage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 5,
        alignment: WrapAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: const Text(
                          'English',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      leading: Radio<Language>(
                        value: Language.english,
                        groupValue: _language,
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                            changeLanguage(value);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: const Text(
                          'Tiếng Việt',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      leading: Radio<Language>(
                        value: Language.vietnamese,
                        groupValue: _language,
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                            changeLanguage(value);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: const Text(
                          'Français',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      leading: Radio<Language>(
                        value: Language.french,
                        groupValue: _language,
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                            changeLanguage(value);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: const Text(
                          'Español',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      leading: Radio<Language>(
                        value: Language.spanish,
                        groupValue: _language,
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                            changeLanguage(value);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: const Text(
                          '中文',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      leading: Radio<Language>(
                        value: Language.chinese,
                        groupValue: _language,
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                            changeLanguage(value);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-16, 0),
                        child: const Text(
                          'Русский',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      leading: Radio<Language>(
                        value: Language.russian,
                        groupValue: _language,
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                            changeLanguage(value);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//change language save in shared preferences
Future<void> changeLanguage(value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("language", value.toString());
}

class RemindDialog extends StatefulWidget {
  const RemindDialog({super.key});

  @override
  State<RemindDialog> createState() => _RemindDialogState();
}

class _RemindDialogState extends State<RemindDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(children: [
        AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: SwitchListTile(
                value: isRemind,
                title: Text(
                  "Nhắc nhở học tập",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                secondary: Icon(Icons.alarm, color: colorApp),
                contentPadding: EdgeInsets.zero,
                onChanged: (bool value) => setState(() {
                      isRemind = value;
                      // Save to shared preferences....
                      //
                    })),
            contentPadding: EdgeInsets.zero,
            alignment: Alignment.center,
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isRemind)
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text("Chọn thời gian trong ngày"),
                      ),
                    if (isRemind)
                      Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: TimeRemindPickerListTile()),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("TimeRemind", timeRemind);
                          prefs.setBool("isRemind", isRemind);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorApp,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Text("Xong"),
                      ),
                    )
                  ],
                ))),
      ]),
    );
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

class TimeRemindPickerListTile extends StatefulWidget {
  const TimeRemindPickerListTile({super.key});

  @override
  State<TimeRemindPickerListTile> createState() =>
      _TimeRemindPickerListTileState();
}

class _TimeRemindPickerListTileState extends State<TimeRemindPickerListTile> {
  String trailing = timeRemind;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Thời gian"),
      trailing: Text(trailing),
      contentPadding: EdgeInsets.only(right: 40),
      onTap: () async {
        final TimeOfDay? TimePick = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: int.parse(timeRemind.split(":")[0]),
              minute: int.parse(timeRemind.split(":")[1].substring(0, 1))),
        );
        // ignore: use_build_context_synchronously
        timeRemind = TimePick != null
            // ignore: use_build_context_synchronously
            ? TimePick.format(context)
            : timeRemind;
        setState(() {
          trailing = timeRemind;
        });
      },
    );
  }
}
