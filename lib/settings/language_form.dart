//Select Language Popup Form

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../utils/get_It.dart';

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
  final prefs = locator<SharedPreferences>();
  prefs.setString("language", value.toString());
}
