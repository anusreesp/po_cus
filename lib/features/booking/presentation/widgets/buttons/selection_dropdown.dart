import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/demo_drinks_model.dart';

class SelectionDropList extends ConsumerWidget {
  final String subtitle;
  final List<DemoDrinksModel> selectedDrinks;
  final void Function(DemoDrinksModel data) select;

  SelectionDropList(
      {Key? key,
      required this.selectedDrinks,
      required this.select,
      required this.subtitle})
      : super(key: key);

  final _scrollController = ScrollController();
  final _isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTile(
      title: Text(
        "",
        style: const TextStyle(
            fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      onExpansionChanged: (value) {
        _isExpanded.value = value;
      },
      trailing: ValueListenableBuilder(
          valueListenable: _isExpanded,
          builder: (_, value, child) {
            return AnimatedRotation(
              turns: value ? 1 / 8 : 1 / 4,
              duration: const Duration(milliseconds: 200),
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xff4a1b3d),
                child: Icon(
                  Icons.add,
                  color: Color(0xffe8d48a),
                ),
              ),
            );
          }),
      subtitle: Row(
        children: [
          Icon(
            Icons.info,
            size: 12,
            color: Colors.grey.shade500,
          ),
          const SizedBox(
            width: 6,
          ),
          SizedBox(
              width: 200,
              child: Text(
                subtitle,
                softWrap: true,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              )),
        ],
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.topLeft,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
              color: const Color(0xffefefe6),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Scrollbar(
            thickness: 10,
            thumbVisibility: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedDrinks.isEmpty)
                    Text(
                      "Select a Drink",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),

                  for (int i = 0; i < selectedDrinks.length; i++)
                    _selectedRow(i, selectedDrinks[i]),

                  // const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "search a drink",
                          hintStyle: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade500),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4)),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  ...sampleDrinksType.map((e) => GestureDetector(
                        onTap: () => select(e),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            e.drinkName,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _selectedRow(int index, DemoDrinksModel data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Drink ${index + 1}\n${data.drinkName}",
            style: const TextStyle(fontSize: 12),
          ),
          const Spacer(),
          // GestureDetector(
          //     onTap: () => deSelect(data),
          //     child: const Image(
          //       image: AssetImage('assets/images/icons/remove_btn.png'),
          //       height: 20,
          //     ))
        ],
      ),
    );
  }
}
