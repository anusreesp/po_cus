import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/booking_details.dart';
import '../data/services/booking_services.dart';

final uniqueIdProvider = StateProvider<String>((ref) {
  return '';
});

final bookingTypeProvider = StateProvider<String>((ref) {
  return '';
});

// class EntryConfirmationController
//     extends StateNotifier<EntryConfirmationStates> {
//   final BookingService _service;
//   final String id;
//   final String type;

//   EntryConfirmationController(this._service, this.id, this.type)
//       : super(EntryConfirmationLoading()) {
//     getBookingDetails();
//   }

//   getBookingDetails() async {
//     try {
//       state = EntryConfirmationLoading();
//       final bookingDetails = await _service.getBookingData(id, type);
//       state = EntryConfirmationLoaded(bookingDetails);
//     } catch (e) {
//       state = EntryConfirmationError(e.toString());
//     }
//   }
// }

// abstract class EntryConfirmationStates {}

// class EntryConfirmationLoaded extends EntryConfirmationStates {
//   final BookingResponseData bookingDetails;
//   EntryConfirmationLoaded(this.bookingDetails);
// }

// class EntryConfirmationLoading extends EntryConfirmationStates {}

// class EntryConfirmationError extends EntryConfirmationStates {
//   final String msg;
//   EntryConfirmationError(this.msg);
// }
