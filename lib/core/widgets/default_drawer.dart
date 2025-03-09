import 'package:flutter/material.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/utils/assets/assets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white.withOpacity(0.8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.primaryColor.withOpacity(0.4),
              context.secondaryHeaderColor.withOpacity(0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Image.asset(AssetsData.logo, fit: BoxFit.cover, width: 150),
                  SizedBox(height: 10),
                  Text(
                    "Welcome admin",
                    style: TextStyle(
                      color: context.primaryColorDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "admin@gmail.com",
                    style: TextStyle(color: context.primaryColorDark),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            // UserAccountsDrawerHeader(
            //   accountName: Text(
            //     "Welcome admin",
            //     style: TextStyle(
            //       color: context.primaryColorDark,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //     ),
            //   ),
            //   accountEmail: Text(
            //     "admin@gmail.com",
            //     style: TextStyle(color: context.primaryColorDark),
            //   ),
            //   // currentAccountPicture: CircleAvatar(
            //   //   backgroundColor: context.secondaryHeaderColor.withOpacity(0.1),
            //   //   backgroundImage: AssetImage(AssetsData.logo),
            //   // ),
            //   currentAccountPicture: Image.asset(
            //     AssetsData.logo,
            //     fit: BoxFit.cover,
            //   ),
            //   currentAccountPictureSize: Size.square(100),
            //   decoration: BoxDecoration(color: Colors.transparent),
            // ),
            _createDrawerItem(
              context,
              icon: MdiIcons.viewDashboard,
              text: 'Dashboard',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: MdiIcons.domain,
              text: 'Companies',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: MdiIcons.accountMultiple,
              text: 'Employees',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: MdiIcons.fileDocument,
              text: 'Documents',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: MdiIcons.chartBar,
              text: 'Reports',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: MdiIcons.handshake,
              text: 'Requests',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: MdiIcons.hammerWrench,
              text: 'Setup',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: MdiIcons.magicStaff,
              text: 'Generate',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // const Divider(color: Colors.white70),
            // ListTile(
            //   title: const Text('About', style: TextStyle(color: Colors.white)),
            //   leading: Icon(Icons.info, color: context.secondaryHeaderColor),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: context.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      leading: Icon(icon, color: context.primaryColorDark),
      onTap: onTap,
    );
  }
}
