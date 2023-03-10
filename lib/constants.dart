import 'package:flutter/material.dart';
import 'package:toeic_app/settings/language_form.dart';

const String appName = "TOEIC APP";
const String appIcon = 'assets/img/headphones.png';

const Color colorApp = Color.fromRGBO(0, 181, 204, 1);
const Color colorAppBold = Color.fromRGBO(1, 107, 121, 1);
const Color colorApp3 = Color.fromRGBO(0, 181, 204, 0.3);
const Color colorApp5 = Color.fromRGBO(0, 181, 204, 0.5);
const Color yellowBold = Color.fromARGB(255, 232, 210, 20);
Color colorBox = Colors.black.withOpacity(0.4);
Color colorBoxShadow = Colors.grey.withOpacity(0.5);
Color textColor = Colors.black;
Color bottomNavColor = colorApp;
Color textNav = Colors.grey.withOpacity(0.5);
Color orange = Colors.amber[600]!;
Color white = Colors.white;
Color black = Colors.black;
Color green = Colors.green;
Color red = Colors.red;
Color transparent = Colors.red.withOpacity(0);

bool isDarkMode = false;

List<String> answersOption = ["A", "B", "C", "D"];

final List<String> listImage = [
  'assets/img/image_icon.png',
  'assets/img/qa.png',
  'assets/img/chat.png',
  'assets/img/headphones.png',
  'assets/img/vocabulary.png',
  'assets/img/form.png',
  'assets/img/book.png',
];

final List<String> listDesc = [
  'Mô tả ảnh',
  'Hỏi & đáp',
  'Đoạn hội thoại',
  'Đoạn nói chuyện ngắn',
  'Điền vào câu',
  'Điền vào đoạn',
  'Đọc hiểu đoạn văn'
];

final List<String> listTitle = [
  'Part 1',
  'Part 2',
  'Part 3',
  'Part 4',
  'Part 5',
  'Part 6',
  'Part 7'
];

final List<String> listDirectionEng = [
  'For each question in this part, you will hear four statements about a picture in your test book. When you hear the statements, you must select the one statement that best describes what you see in the picture. Then find the number of the question on your answer sheet and mark your answer. The statements will not be printed in your text book and will be spoken only one time.',
  'You will hear a question or statement and three responses spoken in English. They will not be printed in your text book and will be spoken only one time. Select the best response to the question or statement and mark the letter (A), (B), (C) on your answer sheet.',
  'You will hear some conversations between two or more people. You will be asked to answer three questions about what the speakers say in each conversation. Select the best response to each question and mark the letter (A), (B), (C), or (D) on your answer sheet. The conversations will not be printed in your test book and will be spoken only one time',
  'You will hear some talks given by a single speaker. You will be asked to answer three questions about what the speaker says in each talk. Select the best response to each question and mark the letter (A), (B), (C), or (D) on your answer sheet. The talks will not be printed in your test book and will be spoken only one time',
  'A word or phrase is missing in each of the sentences below. Four answer choices are given below each sentence. Select the best answer to complete the sentence. Then mark the letter (A), (B), (C), or (D) on your answer sheet',
  'Read the texts that follow. A word, phrase, or sentence is missing in parts of each text. Four answer choices for each question are given below the text. Select the best answer to complete the text. Then mark the letter (A), (B), (C), or (D) on your answer sheet',
  'In this part you will read a selection of texts, such as magazine and newspaper articles, e-mails, and instant messages. Each text or set of texts is followed by several questions. Select the best answer for each question and mark the letter (A), (B), (C), or (D) on your answer sheet'
];

final List<String> listDirectionVn = [
  'Đối với mỗi câu hỏi trong phần này, bạn sẽ nghe bốn câu phát biểu về một bức tranh trong tập kiểm tra của mình. Khi bạn nghe các câu nói, bạn phải chọn một câu mô tả đúng nhất những gì bạn nhìn thấy trong hình. Sau đó tìm số của câu hỏi trên phiếu trả lời của bạn và đánh dấu câu trả lời của bạn. Các câu lệnh sẽ không được in trong sách giáo khoa của bạn và sẽ chỉ được nói một lần',
  'Bạn sẽ nghe một câu hỏi hoặc một câu nói và ba câu trả lời bằng tiếng Anh. Chúng sẽ không được in trong sách giáo khoa của bạn và sẽ chỉ được nói một lần. Chọn câu trả lời đúng nhất cho câu hỏi hoặc câu phát biểu và đánh dấu chữ cái (A), (B), (C) trên phiếu trả lời của bạn.',
  'Bạn sẽ nghe thấy một số đoạn hội thoại giữa hai hoặc nhiều người. Bạn sẽ được yêu cầu trả lời ba câu hỏi về những gì người nói nói trong mỗi cuộc trò chuyện. Chọn câu trả lời đúng nhất cho mỗi câu hỏi và đánh dấu chữ cái (A), (B), (C) hoặc (D) trên phiếu trả lời của bạn. Các đoạn hội thoại sẽ không được in trong tập kiểm tra của bạn và sẽ chỉ được nói một lần  ',
  'Bạn sẽ nghe một số cuộc nói chuyện được đưa ra bởi một diễn giả duy nhất. Bạn sẽ được yêu cầu trả lời ba câu hỏi về những gì diễn giả nói trong mỗi bài nói. Chọn câu trả lời đúng nhất cho mỗi câu hỏi và đánh dấu chữ cái (A), (B), (C) hoặc (D) trên phiếu trả lời của bạn. Các bài nói sẽ không được in trong tập kiểm tra của bạn và sẽ chỉ được nói một lần',
  'Một từ hoặc cụm từ bị thiếu trong mỗi câu dưới đây. Bốn lựa chọn trả lời được đưa ra dưới mỗi câu. Chọn đáp án đúng nhất để hoàn thành câu. Sau đó đánh dấu chữ cái (A), (B), (C) hoặc (D) trên phiếu trả lời của bạn',
  'Đọc các văn bản sau. Một từ, cụm từ hoặc câu bị thiếu trong các phần của mỗi văn bản. Bốn lựa chọn trả lời cho mỗi câu hỏi được đưa ra bên dưới văn bản. Chọn câu trả lời đúng nhất để hoàn thành đoạn văn. Sau đó đánh dấu chữ cái (A), (B), (C) hoặc (D) trên phiếu trả lời của bạn',
  'Trong phần này, bạn sẽ đọc tuyển tập các văn bản, chẳng hạn như các bài báo và tạp chí, e-mail và tin nhắn nhanh. Mỗi văn bản hoặc bộ văn bản được theo sau bởi một số câu hỏi. Chọn câu trả lời đúng nhất cho mỗi câu hỏi và đánh dấu chữ cái (A), (B), (C) hoặc (D) trên phiếu trả lời của bạn'
];

String language = "";
Language? enumLanguage;

bool isRemind = false;

String timeRemind = "00:00";
