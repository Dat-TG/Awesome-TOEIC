// import 'package:flutter/material.dart';
// import 'package:toeic_app/part/part_one.dart';

// import 'app_bar.dart';


// class ReviewQuestionDialog extends StatefulWidget {
//   final int part;
//   const ReviewQuestionDialog({super.key, required this.part});

//   @override
//   State<ReviewQuestionDialog> createState() => _ReviewQuestionDialogState();
// }

// class _ReviewQuestionDialogState extends State<ReviewQuestionDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarPractice(
//           numAnswers: '${i + 1}.${j + 1}', ansTrans: [], answers: []),
//       body: widget.part == 1
//           ? PartOneFrame(
//               number: 0,
//               getAnswer: (nume, val) {},
//               ans: ans,
//               rightAnswers: widget.listRightAnswers,
//               listNameImages: convertListDynamicToListString(
//                   widget.listQuestions[i]['images']),
//               audio: widget.listQuestions[i]['audio'] as String)
//           : part == 2
//               ? PartTwoFrame(
//                   number: 0,
//                   audioPath: widget.listQuestions[i]['audio'] as String,
//                   getAnswer: (nume, val) {},
//                   ans: ans,
//                   rightAnswers: widget.listRightAnswers)
//               : part == 3
//                   ? PartThreeFrame(
//                       number: [1, 2, 3],
//                       audioPath: widget.listQuestions[i]['audio'] as String,
//                       images: widget.listQuestions[i]['images'],
//                       question: convertListDynamicToListString(
//                           widget.listQuestions[i]['list_question']),
//                       answers: [],
//                       getAnswer: (nume, val) {},
//                       ans: ans,
//                       rightAnswers: widget.listRightAnswers)
//                   : SizedBox.shrink(),
//     );
//     ;
//   }
// }