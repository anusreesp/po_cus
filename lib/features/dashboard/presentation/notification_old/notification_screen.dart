// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/features/dashboard/controllers/notifications_controller.dart';
// import 'package:htp_customer/features/dashboard/data/models/notifications_model.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../../htp_theme.dart';
//
// class NotificationsScreen extends ConsumerWidget {
//   static const route = '/notifications';
//   const NotificationsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return RefreshIndicator(
//       onRefresh: ()async{
//         ref.read(notificationsProvider.notifier).init();
//       },
//       child: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//               pinned: true,
//               floating: true,
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               elevation: 0,
//               expandedHeight: 80,
//               excludeHeaderSemantics: true,
//               titleTextStyle: const TextStyle(fontSize: 14),
//               title: Text('Notifications', style: HtpTheme.newTitleTextStyle,),
//               // title: const Image(
//               //   image: AssetImage('assets/images/logos/htp_logo_gold.png'),
//               //   height: 50,
//
//               // ),
//               leading: const DrawerIcon(),
//               leadingWidth: 50,
//               // actions: const [
//               //   Padding(
//               //     padding: EdgeInsets.only(right: 12.0),
//               //     child: ProfileIcon(),
//               //   )
//               // ],
//               flexibleSpace: const FlexibleSpaceBar(
//                 background: SizedBox(
//                   height: 20,
//                   width: double.infinity,
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     // child: Padding(
//                     //   padding:
//                     //   EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
//                     //   child: SearchBox(),
//                     // ),
//                   ),
//                 ),
//               )),
//           SliverList(
//               delegate: SliverChildListDelegate([
//                 _buildBody(),
//                 const SizedBox(height: 80,)
//               ]))
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildBody(){
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(
//             left: 12,
//             right: 12
//         ),
//         child: Consumer(
//           builder: (context, ref, _){
//             final controller = ref.watch(notificationsProvider);
//
//             if(controller is NotificationsLoading){
//               return const Center(child: CircularProgressIndicator(),);
//             }
//
//             if(controller is NotificationsLoaded){
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Padding(
//                   //   padding: const EdgeInsets.only(
//                   //     bottom: 8.0,
//                   //   ),
//                   //   child: Text(
//                   //     'Notifications',
//                   //     style: HtpTheme.newTitleTextStyle,
//                   //   ),
//                   // ),
//
//                   // const SizedBox(height: 12,),
//
//                   if(controller.notifications.isEmpty)
//                     const _Placeholder(),
//
//                   ...controller.notifications.map((data) => Dismissible(
//                       key: Key(data.id!),
//                       onDismissed: (dismissDirection){
//                         ref.read(notificationsProvider.notifier).deleteNotification(data.id!);
//                       },
//                       child: _NotificationBox(notification: data)))
//
//                 ],
//               );
//             }
//
//
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _NotificationBox extends ConsumerWidget {
//   final NotificationsModel notification;
//   const _NotificationBox({
//     Key? key,
//     required this.notification
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return GestureDetector(
//       onTap: (){
//         print(notification.toJson());
//         if(notification.readStatus == false){
//           ref.read(notificationsProvider.notifier).readNotification(notification.id!);
//         }
//         // redirectUrl(notification.url ?? '', notification.internalRedirect, ref);
//
//         if(notification.internalRedirect){
//
//           ref.read(notificationsProvider.notifier).redirectNotification(notification);
//         }else{
//           try{
//             launchUrl(Uri.parse(notification.url ?? ''));
//           }catch(e){
//             debugPrint(e.toString());
//           }
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         margin: const EdgeInsets.only(bottom: 6),
//         decoration: BoxDecoration(
//             color: const Color(0xff171717),
//             borderRadius: BorderRadius.circular(10)
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SvgPicture.asset('assets/svg/icons/notifications.svg', color: notification.readStatus ? const Color(0xff5b5b5b) : null ),
//
//             const SizedBox(width: 8,),
//
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(notification.title, style: const TextStyle(fontSize: 16),),
//                   notification.body == null
//                       ? const SizedBox(height: 12,)
//                       : Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Text(notification.body!, style: const TextStyle(fontSize: 13, color: Colors.white70),),
//                         ),
//                   Text(timeText(notification.createdAt), style: const TextStyle(fontSize: 10, color: Colors.white70),)
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   String timeText(DateTime dateTime){
//     final now = DateTime.now();
//     final diff = now.difference(dateTime);
//
//     if(diff.inMinutes <= 60){
//       return '${diff.inMinutes} min. ago';
//     }
//
//     if(diff.inHours <= 24){
//       return '${diff.inHours} hr. ago';
//     }
//
//     if(diff.inDays == 1){
//       return '1 day ago';
//     }
//     if(diff.inDays <= 30){
//       return '${diff.inDays} days ago';
//     }
//
//     return DateFormat('dd MMMM yyyy').format(dateTime);
//   }
// }
//
// class _Placeholder extends StatelessWidget {
//   const _Placeholder({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           children: [
//             SvgPicture.asset('assets/svg/icons/notifications.svg',
//               height: 80,
//               color: Colors.white12,
//             ),
//             const SizedBox(height: 6,),
//             const Text('All quiet on the notification front. Enjoy your night and check back later for updates.',
//               style: TextStyle(fontSize: 16, color: Colors.white38),
//               textAlign: TextAlign.center,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
