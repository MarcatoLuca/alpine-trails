import 'package:flutter/material.dart';
import 'package:flutter_application/enums.dart';
import 'package:flutter_application/providers/pagenotifier.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required index}) : currentPageIndex = index;

  final int currentPageIndex;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return NavigationBar(
      height: 60,
      selectedIndex: widget.currentPageIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      onDestinationSelected: (int index) {
        setState(() {
          switch (index) {
            case 0:
              {
                if (notifier.pageName != PageName.home) {
                  notifier.changePage(page: PageName.home, unknown: false);
                }
                break;
              }
            case 1:
              {
                if (notifier.pageName != PageName.contact) {
                  notifier.changePage(page: PageName.contact, unknown: false);
                }
                break;
              }
            case 2:
              {
                if (notifier.pageName != PageName.services) {
                  notifier.changePage(page: PageName.services, unknown: false);
                }
                break;
              }
            case 3:
              {
                if (notifier.pageName != PageName.about) {
                  notifier.changePage(page: PageName.about, unknown: false);
                }
                break;
              }
          }
        });
      },

      destinations: <Widget>[
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.list_alt), label: 'Contact'),
        NavigationDestination(icon: Icon(Icons.hiking), label: 'Services'),
        NavigationDestination(icon: Icon(Icons.info), label: 'About'),
      ],
    );
  }
}

class NavigationItem extends StatelessWidget {
  final PageName page;
  final VoidCallback onTap;
  const NavigationItem({required this.page, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(page.name, style: const TextStyle(fontSize: 18.0)),
    );
  }
}
