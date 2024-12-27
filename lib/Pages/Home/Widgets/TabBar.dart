import 'package:flutter/material.dart';

myTabBar(TabController tabController, BuildContext context){
  return PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: TabBar(
            controller: tabController,
            indicatorWeight: 5,
            unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            tabs: const [
              Text("Chats"),
              Text("Groups"),
              Text("Calls"),
            ]
        )
    );


}