import 'package:flutter/material.dart';
import './task_item.dart';

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

class Plan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _allPages.length,
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: new AspectRatio(
              aspectRatio: 8.0,
              child: new TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2.0,
                labelColor: Colors.black,
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
              physics: new NeverScrollableScrollPhysics(),
              children: _allPages.map((HeaderItemBean page) {
                return new TaskItem(items: [
                  {
                    'value': '111',
                    'done': true,
                  },
                  {
                    'value': 'bbb',
                    'done': false,
                  },
                  {
                    'value': 'ccc',
                    'done': false,
                  },
                  {
                    'value': '444',
                    'done': false,
                  },
                  {
                    'value': '555',
                    'done': true,
                  },
                  {
                    'value': '666',
                    'done': false,
                  },
                  {
                    'value': '777',
                    'done': true,
                  },
                  {
                    'value': '888',
                    'done': false,
                  },
                  {
                    'value': '999',
                    'done': false,
                  }
                ]);
              }).toList()
            )
          )
        ]
      )
    );
  }
}
