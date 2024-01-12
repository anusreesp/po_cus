

import 'package:flutter_riverpod/flutter_riverpod.dart';

final photoListProvider = StateNotifierProvider.autoDispose.family<PhotoList, List<String>, List<String>>((ref, photos) => PhotoList(photos));

class PhotoList extends StateNotifier<List<String>>{
  final List<String> allPhotos;
  PhotoList(this.allPhotos):super([]){
    loadPhotos();
  }

  loadPhotos(){
    //Photos are less than 4
    if(allPhotos.length <= 4){
      state = allPhotos;
      return;
    }
    //Photos are more than 4
    if(allPhotos.length > 4 && state.length < 4){
      state = allPhotos.sublist(0, 4);
      return;
    }
      //Remaining photos are more than 4
    if(allPhotos.length > state.length){
      if((allPhotos.length - state.length) >= 4){
        state = [...state, ...allPhotos.sublist(state.length, (state.length + 4))];
      }else{
        state = [...state, ...allPhotos.sublist(state.length)];
      }
    }

  }
}