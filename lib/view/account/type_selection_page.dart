import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:one_saved/utils/type.dart';
import 'package:one_saved/view/account/add_account_page.dart';
import 'package:one_saved/widgets/appbar.dart';

class TypeSelectionPage extends StatefulWidget {
  const TypeSelectionPage({Key? key}) : super(key: key);

  @override
  State<TypeSelectionPage> createState() => _TypeSelectionPageState();
}

class _TypeSelectionPageState extends State<TypeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: Text("Select Account")),
      body: GridView.builder(
          itemCount: type.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Get.to(() => AddAccountPage(type[index]['type']!));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: type[index]['type'] == "other"
                              ? Image.asset("assets/icons/other.png")
                              : SvgPicture.asset(type[index]['image']!),
                        ),
                        Text(type[index]['title']!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
