import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                    onTap: () => print(entries[index]),
                    trailing: entries.elementAt(index) == "Phiên bản"
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [Text(version)],
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
    final prefs = await SharedPreferences.getInstance();
    changeColorByTheme();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
    });
  }

  //Incrementing counter after click
  Future<void> _changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    changeColorByTheme();
    setState(() {
      prefs.setBool('DarkMode', isDarkMode);
    });
  }

  
}
