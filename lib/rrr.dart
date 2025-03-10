// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Quiz App'),
//           backgroundColor: Colors.black,
//         ),
//         body: const QuizScreen(),
//       ),
//     );
//   }
// }
//
// class QuizScreen extends StatelessWidget {
//   const QuizScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Daily Challenge
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   blurRadius: 5,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Daily Challenge",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 5),
//                 const Text("Complete today's quiz and earn bonus XP!"),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     onPressed: () {},
//                     child: const Text("Start Daily Challenge"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // Categories Section
//           const Text(
//             "Categories",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           GridView.count(
//             crossAxisCount: 2,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             children: [
//               _categoryCard(Icons.history, "History", Colors.red),
//               _categoryCard(Icons.science, "Science", Colors.blue),
//               _categoryCard(Icons.public, "Geography", Colors.green),
//               _categoryCard(Icons.menu_book, "Literature", Colors.amber),
//             ],
//           ),
//
//           const SizedBox(height: 20),
//
//           // Featured Quizzes
//           const Text(
//             "Featured Quizzes",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           _quizCard("World Capitals", "Geography", "Medium"),
//           _quizCard("Famous Scientists", "Science", "Hard"),
//           _quizCard("Ancient Civilizations", "History", "Easy"),
//         ],
//       ),
//     );
//   }
//
//   Widget _categoryCard(IconData icon, String title, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: color, size: 40),
//           const SizedBox(height: 10),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _quizCard(String title, String category, String difficulty) {
//     return Card(
//       elevation: 2,
//       child: ListTile(
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(category),
//         trailing: Text(
//           difficulty,
//           style: const TextStyle(color: Colors.orange),
//         ),
//       ),
//     );
//   }
// }
