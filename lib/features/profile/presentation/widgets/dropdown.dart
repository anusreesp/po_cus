import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool dropbutton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 6,
              ),
              dropbutton == true
                  ? const Text(
                      "Hide Price Breakdown",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  : const Text(
                      "View Price Breakdown",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
              const Spacer(),
              dropbutton == false
                  ? Container(
                      child: GestureDetector(
                        child: const Image(
                          fit: BoxFit.cover,
                          height: 18,
                          width: 18,
                          image: AssetImage(
                            "assets/images/icons/arrow-down.png",
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            dropbutton = true;
                          });
                        },
                      ),
                    )
                  : Container(
                      child: GestureDetector(
                        child: const Image(
                          fit: BoxFit.cover,
                          height: 18,
                          width: 18,
                          image: AssetImage(
                            "assets/images/icons/gold-arrow-up.png",
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            dropbutton = false;
                          });
                        },
                      ),
                    )
            ],
          ), //-----------------view details----------------------
          dropbutton == true
              ? Container(
                  height: 150,
                  width: 330,
                  padding: EdgeInsets.only(top: 4),
                  child: Column(
                    children: [
                      dropData("Club fee", "\$190"),
                      dropData("+1 Member", "\$90"),
                      dropData("Service Charge/Tax", "\$50"),
                      SizedBox(
                        height: 3,
                      ),
                      const Divider(
                        height: 1,
                        color: Color.fromARGB(255, 158, 158, 158),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      dropData("Amount Taxable", "\$499")
                    ],
                  ))
              : const Padding(padding: EdgeInsets.all(8))
        ],
      ),
    );
  }

  Widget dropData(String name, String data) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
            const Spacer(),
            Text(
              data,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
          ],
        ));
  }
}
