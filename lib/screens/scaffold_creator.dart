import 'package:flutter/material.dart';
import 'package:work_journal/models/skill.dart';
import 'package:work_journal/screens/home_screen.dart';
import 'package:work_journal/screens/skills_screen.dart';

class ScaffoldCreator {
  static Scaffold create(BuildContext context, String title, Widget body,
      FloatingActionButton leftFab, FloatingActionButton rightFab) {
    List<Widget> fabs = <Widget>[];

    if (leftFab != null) {
      fabs.add(
        Align(alignment: Alignment.bottomLeft, child: leftFab),
      );
    }

    if (rightFab != null) {
      fabs.add(Align(
        alignment: Alignment.bottomRight,
        child: rightFab,
      ));
    }

    Widget fab = Container(
        padding: EdgeInsets.only(left: 30), child: Stack(children: fabs));
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text("JK"),
                    backgroundColor: Theme.of(context).textTheme.body1.color,
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  Text("TODO - Show user info")
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: RouteSettings(isInitialRoute: true),
                        builder: (context) {
                          return HomeScreen();
                        }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.work,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Accomplishments",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: RouteSettings(isInitialRoute: true),
                        builder: (context) {
                          return SkillsScreen(Key(
                              "SkillsScreen_${SkillsDB.instance.getWorkingCopy().length}"));
                        }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.build,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Skills",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
            )
          ],
        )),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        body: body,
        floatingActionButton: fab);
  }
}
