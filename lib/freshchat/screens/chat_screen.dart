// import 'package:freshchat_sdk/freshchat_sdk.dart';
// import 'package:flutter/material.dart';
// import 'package:freshchat_sdk/freshchat_user.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     initialize();
//
//     // FreshchatUser freshchatUser = Freshchat.getUser();
//     // FreshchatUser.setFirstName('firstName');
//
//   }
//
//   initialize() async{
//     Freshchat.init(
//       '83dad3b7-2238-4a06-9352-1cb4a7844e90',
//       '5d8b5435-66c7-4670-9668-884c1455b0b1',
//       'msdk.in.freshchat.com',
//     );
//
//     Freshchat.identifyUser(externalId: 'dipak@exdera.com-ntntttynt');
//
//     FreshchatUser user = await Freshchat.getUser;
//     user.setFirstName('Test name');
//
//     Freshchat.setUser(user);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: CustomAppBar(
//         child: Text('Support'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//
//           TextButton(onPressed: (){
//             Freshchat.showConversations();
//           }, child: Text('Show conversation'))
//         ],
//       ),
//     );
//   }
// }
