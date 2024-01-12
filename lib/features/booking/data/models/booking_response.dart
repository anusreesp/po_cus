
class BookingResponse {
  BookingResponse({
    required this.success,
    required this.message,
    required this.id,
    // required this.qrCode,
  });

  final bool success;
  final String message;
  final String id;
  // final String qrCode;

  factory BookingResponse.fromJson(Map<String, dynamic> json) => BookingResponse(
    success: json["success"],
    message: json["message"],
    id: json["booking_id"],
    // qrCode: json["qr_code"],
  );

  // Map<String, dynamic> toJson() => {
  //   "success": success,
  //   "message": message,
  //   "id": id,
  //   "qr_code": qrCode,
  // };
}
