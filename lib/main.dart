import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'helper-functions.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors
          .transparent, // navigation bar doesn't accept Colors.transparent by default
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slivers Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Slivers Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          MyAppBar(title: widget.title),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(48, 48, 48, 28),
            sliver: MyList(text: 'SliverList 1', length: 4),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              // 2
              minHeight: 60,
              maxHeight: 200,
              // 3
              child: Container(
                color: randomColor(),
                child: Center(
                  child: Text(
                    'SliverPersistentHeader',
                    style: cardTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(28),
            sliver: MyList(text: 'SliverList 2', length: 20),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 40),
              child: Column(
                children: const [
                  MyCard(
                    text: 'SliverToBoxAdapter',
                  ),
                  MyCard(
                    text: 'SliverToBoxAdapter',
                  ),
                  MyCard(
                    text: 'SliverToBoxAdapter',
                  ),
                  MyCard(
                    text: 'SliverToBoxAdapter',
                    noMargin: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class MyAppBar extends StatelessWidget {
  final String title;
  const MyAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 210,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ))
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        titlePadding: EdgeInsets.zero,
        title: SizedBox(
          height: 45,
          child: TextFormField(
            onChanged: (value) {},
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        background: Container(
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                bottom: 80,
                child: Text(title,
                    style: const TextStyle(fontSize: 28, color: Colors.black)),
              ),
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: randomColor(),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyList extends StatelessWidget {
  final String text;
  final int length;
  const MyList({Key? key, required this.text, required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: length,
        (BuildContext context, int index) {
          return MyCard(
            text: text,
            noMargin: index == length - 1 ? true : false,
          );
        },
        // Or, uncomment the following line:
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String text;
  final bool noMargin;
  const MyCard({Key? key, required this.text, this.noMargin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.0,
          decoration: BoxDecoration(
            color: randomColor(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: cardTextStyle(),
            ),
          ),
        ),
        SizedBox(height: noMargin ? 0 : 20),
      ],
    );
  }
}
