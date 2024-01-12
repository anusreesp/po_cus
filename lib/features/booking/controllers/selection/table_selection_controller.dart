

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/controllers/selection/guests_controller.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';

import '../../data/models/club_table_model.dart';

final selectedTableProvider = StateProvider.autoDispose<String?>((ref) => null);

final clubTableProvider = StateNotifierProvider.autoDispose<TableListController, List<SittingTable>>((ref){
  final guests = ref.watch(guestEditProvider);
  return TableListController(ref, guests.length);
});

List<SittingTable> tableList = [
  SittingTable(name: 'Table for 2', count: 2, minimumSpent: 500, seaterCount: 2),
  SittingTable(name: 'Table for 4', count: 4, minimumSpent: 800, seaterCount: 3),
  SittingTable(name: 'Table for 6', count: 6, minimumSpent: 1000, seaterCount: 3),
  SittingTable(name: 'Table for 8', count: 8, minimumSpent: 1500, seaterCount: 2),
];

class TableListController extends StateNotifier<List<SittingTable>>{
  final Ref _ref;
  final int _guestCount;
  TableListController(this._ref, this._guestCount):super([]){
    init();
  }



  setTable(List<SittingTable> tables){
    //TODO: Uncomment to
    tableList = tables;
    state = tables;
  }

  init(){
    state = tableList;
    print("TABLE CREATED");
    updateTableWithCount(_guestCount);
  }

  @override
  void dispose() {
    super.dispose();
    print("TABLE DISPOSED");
  }

  SittingTable? selectedTable;

  selectTable(SittingTable data){
    _ref.read(selectedTableProvider.notifier).state = data.name;
    selectedTable = data;
  }

  updateTableWithCount(int count){
    print("GUEST COUNT $count");
    _ref.read(selectedTableProvider.notifier).state = null;
    selectedTable = null;
    final newList = tableList.where((element) => element.count >= count).toList();
    if(newList.isEmpty){
      state = [];
      // state = tableList;
    }else{
      state = newList;
    }
  }

}