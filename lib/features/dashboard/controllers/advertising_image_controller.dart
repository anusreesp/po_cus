import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvertisingImagesController
    extends StateNotifier<AdvertisingImagesStates> {
  AdvertisingImagesController() : super(AdvertisingImagesLoading()) {
    getImages();
  }

  getImages() async {
    try {
      state = AdvertisingImagesLoading();
      final data;
    } catch (e) {
      state = AdvertisingImagesError();
    }
  }
}

abstract class AdvertisingImagesStates {}

class AdvertisingImagesLoading extends AdvertisingImagesStates {}

class AdvertisingImagesLoaded extends AdvertisingImagesStates {
  AdvertisingImagesLoaded();
}

class AdvertisingImagesError extends AdvertisingImagesStates {
  AdvertisingImagesError();
}
