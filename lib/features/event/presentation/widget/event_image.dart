import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/event/data/services/events_services.dart';

import '../../data/models/event_list_response.dart';
import '../../data/models/event_model.dart';

class EventImage extends ConsumerWidget {
  final EventDataApi data;
  const EventImage({required this.data, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<EventModel>(
      future: ref.read(eventServiceProvider).getSingleEvent(data.id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final EventModel snapShotData = snapshot.data;

          return Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                data.displayImage != null
                    ? Image(
                        fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.40,
                    width: MediaQuery.of(context).size.width,
                    image: NetworkImage(data.displayImage!))
                    : const Image(
                        image: AssetImage(
                            'assets/images/placeholders/placeholder_15.png'),
                        fit: BoxFit.cover,
                      ),
                snapShotData.logo == null
                    ? SizedBox()
                    : Positioned(
                        bottom: 10,
                        left: 15,
                        child: CircleAvatar(
                            radius: 29,
                            //-------------------------------------Change here--------------------------------------
                            backgroundImage:
                                const AssetImage('assets/images/logoBg.png'),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image(
                                image: NetworkImage("${snapShotData.logo}"),
                                // AssetImage(
                                //     'assets/images/temp/profile.png'),
                                height: 55,
                                width: 55,
                                fit: BoxFit.cover,
                              ),
                            ))),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
