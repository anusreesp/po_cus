// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/booking/controllers/selection/date_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/drinks_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/guests_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/smoke_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/table_selection_controller.dart';
// import 'package:htp_customer/features/event/controllers/guest_controller_event.dart' as e;
// import 'package:htp_customer/features/event/data/models/event_model.dart';
// import 'package:intl/intl.dart';

// import '../data/models/guest_model.dart';
// import '../data/services/booking_services.dart';

// final bookingProvider =
//     StateNotifierProvider.autoDispose<BookingController, BookingStates>((ref) {
//   final service = ref.watch(bookingServiceProvider);
//   return BookingController(service, ref);
// });

// // final datePickController = ref.watch(datePickProvider);
// // final drinkController = ref.watch(drinkProvider);
// // final smokeController = ref.watch(smokeProvider);
// // final guestController = ref.watch(guestEditProvider);
// // final preferredTableController = ref.watch(clubTableProvider);
// // final selectedTableController = ref.watch(selectedTableProvider);
// // final timeSlotController = ref.watch(slotPickProvider);

// class BookingController extends StateNotifier<BookingStates> {
//   final BookingService _service;
//   final Ref _ref;
//   // final List<GuestModel> _guests;
//   // final List<GuestModel> _guestsEvent;
//   BookingController(this._service, this._ref)
//       : super(BookingInitialState());

//   String clubId = '';
//   String clubName = '';
//   EventModel? eventData;

//   bookEntry(List<GuestModel> guests) async {
//     final bookingDate = _ref.read(datePickProvider.notifier).state;
//     if (bookingDate == null) {
//       state = BookingError('Date not selected!');
//       return;
//     }

//     final bookingTime = _ref.read(slotPickProvider.notifier).state;
//     if(bookingTime == null){
//       state = BookingError('Time not selected!');
//       return;
//     }

//     try {
//       state = BookingLoading();
//       final response = await _service.submitEntryBooking(
//           clubId: clubId,
//           clubName: clubName,
//           date: DateFormat('yyyy-MM-dd').format(bookingDate),
//           guest: guests,
//           arrivalTime: bookingTime
//       );
//       state = BookingSuccess(response.id, 'club_entry_booking');
//     } catch (e) {
//       state = BookingError(e.toString());
//     }
//   }

//   bookTable(List<GuestModel> guests) async{
//     final bookingDate = _ref.read(datePickProvider.notifier).state;
//     if (bookingDate == null) {
//       state = BookingError('Date not selected!');
//       return;
//     }

//     final bookingTime = _ref.read(slotPickProvider.notifier).state;
//     if(bookingTime == null){
//       state = BookingError('Time not selected!');
//       return;
//     }

//     final tableController = _ref.read(clubTableProvider);
//     final tableSelection = _ref.read(selectedTableProvider.notifier).state;
//     if(tableSelection == null && tableController.isNotEmpty){
//       state = BookingError('Select table!');
//       return;
//     }

//     //Required fields checked
//     try{
//       List<Map<String, dynamic>> productList = [];
//       final drinks = _ref.read(drinkProvider.notifier).state;
//       for(final drink in drinks){
//         productList.add(drink.toJson());
//       }
//       final smokes = _ref.read(smokeProvider.notifier).state;
//       for(final smoke in smokes){
//         productList.add(smoke.toJson());
//       }


//       state = BookingLoading();
//       final response = await _service.submitTableBooking(
//           clubId: clubId, 
//           clubName: clubName, 
//           date: DateFormat('yyyy-MM-dd').format(bookingDate), 
//           guest: guests, 
//           products: productList,
//           arrivalTime: bookingTime, 
//           table: _ref.read(clubTableProvider.notifier).selectedTable?.toJson());
//       state = BookingSuccess(response.id, 'table_booking');
//     }catch(e){
//       state = BookingError(e.toString());
//     }

//   }

//   bookEvent(List<GuestModel> guests) async{
//     try{
//       state = BookingLoading();
//       final response = await _service.submitEventBooking(eventData!.id, guests, eventData!.name, eventData!.entryPerHead);
//       state = BookingSuccess(response.id, 'event_entry_booking');
//     }catch(e){
//       state = BookingError(e.toString());
//     }
//   }


// }

// // enum BookingType {event, club}

// abstract class BookingStates {}

// class BookingInitialState extends BookingStates {}

// class BookingLoading extends BookingStates {}

// class BookingSuccess extends BookingStates {
//   final String bookingId;
//   final String bookingType;
//   BookingSuccess(this.bookingId, this.bookingType);
// }

// class BookingError extends BookingStates {
//   final String msg;
//   BookingError(this.msg);
// }

// //----------------------------------------------------------

// enum CurrentStatus { sent, waiting, qrdisplay, denied }

// final StatusProvider =
//     StateProvider.autoDispose<CurrentStatus>((ref) => CurrentStatus.waiting);
