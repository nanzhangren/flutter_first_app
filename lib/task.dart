import 'package:flutter/material.dart';

class HeaderItemBean {
  final String labelTitle;

  HeaderItemBean(this.labelTitle);
}

final List<HeaderItemBean> _allPages = <HeaderItemBean>[
  new HeaderItemBean('今天'),
  new HeaderItemBean('本周'),
  new HeaderItemBean('本月'),
  new HeaderItemBean('今年')
];

class Task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _allPages.length,
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.lightBlue,
            child: new AspectRatio(
              aspectRatio: 8.0,
              child: new TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2.0,
                labelStyle: new TextStyle(
                  fontSize: 16.0
                ),
                tabs: _allPages
                  .map((HeaderItemBean page) => new Tab(text: page.labelTitle))
                  .toList()
              )
            )
          ),
          new Expanded(
            child: new TabBarView(
              children: _allPages.map((HeaderItemBean page) {
                return Container(
                  child: Text(page.labelTitle)
                );
              }).toList()
            )
          )
        ]
      )
    );
  }
}