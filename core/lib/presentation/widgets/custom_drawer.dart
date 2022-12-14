import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/tv/presentation/pages/home_tv_page.dart';
import 'package:core/tv/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../../provider/tab_menu_notifier.dart';
import '../pages/watchlist_movies_page.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  CustomDrawer({
    required this.content,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  Widget _buildDrawer() {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                // backgroundImage: CachedNetworkImage(
                //   imageUrl:
                //       'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_expert_academy/dicoding-icon.png',
                //   placeholder: (context, url) => Center(
                //     child: CircularProgressIndicator(),
                //   ),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ) as ImageProvider,
                ),
            accountName: Text('Andy'),
            accountEmail: Text('andyyy@dicoding.com'),
          ),
          ListTile(
            onTap: () {
              Provider.of<TabMenuNotifier>(context, listen: false)
                  .currentMenuTab = MenuTabState.Movie;
              _animationController.reverse();
            },
            leading: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          ListTile(
            onTap: () {
              Provider.of<TabMenuNotifier>(context, listen: false)
                  .currentMenuTab = MenuTabState.Tv;
              _animationController.reverse();
            },
            leading: Icon(Icons.tv),
            title: Text('TV'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              _animationController.reverse();
            },
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist Movie'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              _animationController.reverse();
            },
            leading: Icon(Icons.save_outlined),
            title: Text('Watchlist TV'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ABOUT_ROUTE);
              _animationController.reverse();
            },
            leading: Icon(Icons.save_outlined),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child:
                    Consumer<TabMenuNotifier>(builder: (context, data, child) {
                  final state = data.currentMenuTab;
                  if (state == MenuTabState.Movie) {
                    return HomeMoviePage();
                  } else if (state == MenuTabState.Tv) {
                    return HomeTvPage();
                  }
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
