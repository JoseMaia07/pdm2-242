import 'package:flutter/material.dart';
import 'package:flutter_application_1/telas/tela-inicial.dart';
import 'package:flutter_application_1/telas/tela-2t.dart';
import 'package:flutter_application_1/telas/tela-perfil.dart'; // Importe Tela2t

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items})
      : super(key: key);

  @override
  _PersistentBottomBarScaffoldState createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// Check if curent tab can be popped
        if (widget.items[_selectedTab].navigatorkey?.currentState?.canPop() ??
            false) {
          widget.items[_selectedTab].navigatorkey?.currentState?.pop();
          return false;
        } else {
          // if current tab can't be popped then use the root navigator
          return true;
        }
      },
      child: Scaffold(
        /// Using indexedStack to maintain the order of the tabs and the state of the
        /// previously opened tab
        body: IndexedStack(
          index: _selectedTab,
          children: widget.items
              .map((page) => Navigator(
                    /// Each tab is wrapped in a Navigator so that naigation in
                    /// one tab can be independent of the other tabs
                    key: page.navigatorkey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.tab)
                      ];
                    },
                  ))
              .toList(),
        ),

        /// Define the persistent bottom bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          backgroundColor: const Color.fromRGBO(44, 45, 53, 1.0),
          onTap: (index) {
            /// Check if the tab that the user is pressing is currently selected
            if (index == _selectedTab) {
              /// if you want to pop the current tab to its root then use
              widget.items[index].navigatorkey?.currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _selectedTab = index;
              });
            }
          },
          items: widget.items
              .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon), label: item.title))
              .toList(),
        ),
      ),
    );
  }
}

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem(
      {required this.tab,
      this.navigatorkey,
      required this.title,
      required this.icon});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(primary: const Color.fromRGBO(103, 58, 183, 1.0)),
        useMaterial3: true,
      ),
      home: PersistentBottomBarScaffold(
        items: [
          PersistentTabItem(
            tab: TelaInicial(),
            navigatorkey: GlobalKey<NavigatorState>(),
            title: 'Home',
            icon: Icons.home,
          ),
          PersistentTabItem(
            tab: Tela2t(), // Alterado para Tela2t ao invés de "Search"
            navigatorkey: GlobalKey<NavigatorState>(),
            title: 'Contador',
            icon: Icons.bubble_chart_rounded,
          ),
          PersistentTabItem(
            tab: TelaPerfil(),
            navigatorkey: GlobalKey<NavigatorState>(),
            title: 'Perfil',
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
