import 'package:flutter/material.dart';

import '../common/widgets_common/needles_widget.dart';
import '../common/widgets_common/text_field_electra.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          // Text('Test'),
          NeedleDoubleSided(),
          NeedleHorizontal(),
          NeedleVertical(),

          TextFieldElectra(
            hintText: '',
            labelText: '',
          )
        ],
      ),
    );
  }
}
