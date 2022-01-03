import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Center(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color:Colors.black12 ),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
