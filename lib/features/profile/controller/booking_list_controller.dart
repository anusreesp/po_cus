import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../clubs/presentation/widgets/new/club_filter.dart';
import '../data/models/booking_details.dart';
import '../data/services/profile_services.dart';
import 'my_booking_controller.dart';

final bookingListProvider = StateNotifierProvider.autoDispose((ref) {
  final service = ref.watch(profileServiceProvider);
  final sort = ref.watch(selectedClubProvider);
  // final status = ref.watch(myBookingProvider);
  return BookingListController(service, sort);
});

class BookingListController extends StateNotifier<BookingListState> {
  final ProfileServices _services;
  final String sort;
  // final MyBookingStates status;

  BookingListController(this._services, this.sort)
      : super(BookingListLoading()) {
    init();
  }

  Future<void> init() async {
    try {
      state = BookingListLoading();
      final bookings = await _services.getMyBookings();
      state = BookingListLoaded(bookings);
    } catch (e) {
      if (mounted) {
        state = BookingListError(e.toString());
      }
    }
  }
}

abstract class BookingListState {}

class BookingListLoading extends BookingListState {}

class BookingListError extends BookingListState {
  final String msg;
  BookingListError(this.msg);
}

class BookingListLoaded extends BookingListState {
  final List<BookingData> allBookings;
  BookingListLoaded(this.allBookings);

  List<BookingData> get activeBookings {
    try {
      final today = DateTime.now();
      final todayDateOnly =
          DateTime(today.toUtc().year, today.toUtc().month, today.toUtc().day);

      return allBookings
          .where((element) =>
              ((element.bookingDateOnly == todayDateOnly) ||
                  element.bookingDateOnly.isAfter(today)) &&
              // element.status != 'Cancelled' &&
              // element.status != 'Rejected'
              element.status == 'Approved')
          .toList();
    } catch (_) {
      return [];
    }
  }
}
