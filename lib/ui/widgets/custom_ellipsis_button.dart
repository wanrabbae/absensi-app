import 'package:app/models/live_location_action_model/live_location_action_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:supercharged/supercharged.dart';
import 'package:velocity_x/velocity_x.dart';

class EllipsisButton extends StatelessWidget {
  final RxList<LiveLocationActionModel> items;

  const EllipsisButton({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IconButton(
        onPressed: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => ListItems(items: items),
            onPop: () => print('Popover was popped!'),
            direction: PopoverDirection.bottom,
            width: size.width * 0.55,
            height: size.height * 0.3,
            arrowHeight: 10,
            arrowWidth: 20,
            backgroundColor: Colors.white,
            barrierColor: Colors.black.withOpacity(0.1),
          );
        },
        icon: Icon(
          FontAwesomeIcons.ellipsis,
          color: '#1865E2'.toColor(),
        ));
  }
}

class ListItems extends StatelessWidget {
  final RxList<LiveLocationActionModel> items;

  const ListItems({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: items
            .map((element) => GestureDetector(
                  onTap: element.onPressed,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          element.title ?? '-',
                          style: GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        10.widthBox,
                        Obx(() {
                          return Visibility(
                            visible: items.where((p0) => p0.id == element.id).first.isActive,
                            child: Icon(
                              FontAwesomeIcons.checkSquare,
                              color: Vx.gray500,
                              size: 16,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
