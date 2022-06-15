import 'package:flutter/material.dart';

import '../../../../shared/theme.dart';

class CustonButtonPapup extends StatefulWidget {
  final void Function()? onTap;
  final String? text;
  final IconData? icon;
  final List<PopupMenuEntry<int>> Function(BuildContext) itemBuilder;
  final void Function(int)? onSelected;

  const CustonButtonPapup({
    Key? key,
    this.onTap,
    this.text,
    this.icon,
    required this.itemBuilder,
    this.onSelected,
  }) : super(key: key);

  @override
  State<CustonButtonPapup> createState() => _CustonButtonPapupState();
}

class _CustonButtonPapupState extends State<CustonButtonPapup> {
  double _size = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _size = context.size?.height ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: colorB,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Text(widget.text ?? ""),
          ),
          Container(
            width: 1,
            height: _size,
            color: colorC,
            margin: const EdgeInsets.symmetric(horizontal: 5),
          ),
          SizedBox(
            width: 20,
            child: PopupMenuButton(
              tooltip: "Opciones",
              offset: Offset(0, _size),
              padding: const EdgeInsets.all(0),
              splashRadius: 0.1,
              onSelected: widget.onSelected,
              itemBuilder: widget.itemBuilder,
            ),
          )
        ],
      ),
    );
  }
}
