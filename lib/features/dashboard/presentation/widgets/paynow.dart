// import 'package:flutter/material.dart';

// class PayNow extends StatelessWidget {
//   PayNow({super.key});

//   TextStyle clubdetailhint = const TextStyle(
//       fontFamily: "OpenSans",
//       height: 1.5,
//       color: Color.fromRGBO(255, 255, 255, 0.58),
//       fontSize: 10);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: 335,
//       decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.85),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.black.withOpacity(0.25))),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 200,
//                   child: Text(
//                     "Please complete your payment now to confirm reservation",
//                     style: clubdetailhint,
//                     // TextStyle(color: Colors.grey, fontSize: 12)
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 12.0, right: 4),
//                       child: Text('\$', style: clubdetailhint
//                           // TextStyle(color: Colors.grey, fontSize: 11)
//                           ),
//                     ),
//                     const Text(
//                       "499",
//                       style: TextStyle(
//                           fontSize: 25,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600),
//                     )
//                   ],
//                 ),
//                 const Spacer(),
//                 greenButton()
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget greenButton() {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(26),
//             color: const Color.fromARGB(255, 154, 193, 67)),
//         child: const Padding(
//           padding: EdgeInsets.fromLTRB(
//             16,
//             7.0,
//             16,
//             7.0,
//           ),
//           child: Center(
//               child: Text(
//             "Pay now!",
//             style: TextStyle(
//                 color: Colors.white, fontSize: 15, fontFamily: "Open Sans"),
//           )),
//         ),
//       ),
//     );
//   }
// }
