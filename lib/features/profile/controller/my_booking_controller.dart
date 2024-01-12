import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/profile/data/models/booking_details.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';

enum MyBookingStatus { all, clubs, events }

final myBookingProvider =
    StateNotifierProvider.autoDispose<MyBookingController, MyBookingStates>(
        (ref) {
  final services = ref.watch(profileServiceProvider);
  final status = ref.watch(myBookingStatus);
  return MyBookingController(
    services,
    status,
  );
});

final myBookingStatus =
    StateProvider.autoDispose<MyBookingStatus>((ref) => MyBookingStatus.all);

class MyBookingController extends StateNotifier<MyBookingStates> {
  final ProfileServices services;
  final MyBookingStatus status;
  MyBookingController(
    this.services,
    this.status,
  ) : super(MyBookingLoading()) {
    myBookingsList();
  }

  List<BookingData> listOfBooking = [];

  myBookingsList() async {
    try {
      state = MyBookingLoading();
      listOfBooking = await services.getMyBookings();
      final filter = filterSort(listOfBooking);

      // final sortResult = sortFunc(filter);
      state = MyBookingLoaded(filter);
    } catch (e) {
      state = MyBookingError(e.toString());
    }
  }

  // List<BookingData> sortFunc(String sortBy) {
  //   List<BookingData> resultList = [];

  //   listOfBooking.every((element) {
  //     String statusVal = '';

  //     if (status == MyBookingStatus.events) {
  //       statusVal = 'event_entry_booking';
  //     } else if (status == MyBookingStatus.all) {
  //       statusVal = '';
  //     } else {
  //       statusVal = 'club_entry_booking';
  //     }

  //     if (element.bookingType == statusVal) {
  //       resultList.add(element);
  //       if (sortBy == 'Booking Date') {
  //         resultList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
  //       } else {
  //         resultList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  //       }
  //     } else {
  //       resultList.add(element);
  //       if (sortBy == 'Booking Date') {
  //         resultList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
  //       } else {
  //         resultList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  //       }
  //     }

  //     return true;
  //   });
  //   state = MyBookingLoading();
  //   state = MyBookingLoaded(resultList);
  //   return resultList;
  // }

  List<BookingData> sortFunc(String sortBy) {
    List<BookingData> resultList = [];

    switch (status) {
      case MyBookingStatus.all:
        listOfBooking.every((element) {
          resultList.add(element);
          if (sortBy == 'Booking Date') {
            resultList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
          } else {
            resultList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          }

          return true;
        });
      case MyBookingStatus.clubs:
        resultList = listOfBooking
            .where((element) => (element.bookingType == 'club_entry_booking' ||
                element.bookingType == 'table_booking'))
            .toList();

        if (sortBy == 'Booking Date') {
          resultList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
        } else {
          resultList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }

      case MyBookingStatus.events:
        resultList = listOfBooking
            .where((element) => (element.bookingType == 'event_entry_booking'))
            .toList();

        if (sortBy == 'Booking Date') {
          resultList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
        } else {
          resultList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }
    }
    state = MyBookingLoading();
    state = MyBookingLoaded(resultList);
    return resultList;
  }

  List<BookingData> filterSort(List<BookingData> data) {
    try {
      switch (status) {
        case MyBookingStatus.all:
          return data;
        case MyBookingStatus.clubs:
          return data
              .where((element) =>
                  (element.bookingType == 'club_entry_booking' ||
                      element.bookingType == 'table_booking'))
              .toList();
        case MyBookingStatus.events:
          return data
              .where(
                  (element) => (element.bookingType == 'event_entry_booking'))
              .toList();
      }
    } catch (e) {
      return [];
    }
  }
}

abstract class MyBookingStates {}

class MyBookingLoading extends MyBookingStates {}

class MyBookingLoaded extends MyBookingStates {
  List<BookingData> result;
  MyBookingLoaded(this.result);
}

class MyBookingError extends MyBookingStates {
  final String msg;
  MyBookingError(this.msg);
}
