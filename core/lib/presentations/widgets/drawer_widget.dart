import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, MOVIE_PAGE_ROUTE);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('Tv Series'),
            onTap: () {
              Navigator.pushNamed(context, TV_PAGE_ROUTE);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WATCHLIST_ROUTE);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ABOUT_ROUTE);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
