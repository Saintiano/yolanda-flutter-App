import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class MenuDropdown extends StatefulWidget {
  const MenuDropdown({super.key, required this.pullDownMenuItem});

  final List<PullDownMenuEntry> pullDownMenuItem;

  @override
  State<MenuDropdown> createState() => _MenuDropdownState();
}

class _MenuDropdownState extends State<MenuDropdown> {
  @override
  Widget build(BuildContext context) {
    return PullDownButton(
      itemBuilder: (context) => widget.pullDownMenuItem,
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: EdgeInsets.zero,
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.primary,
            size: 25,
          ),
        ),
      ),
    );
  }
}
