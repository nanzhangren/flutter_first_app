import 'package:flutter/material.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart';
import 'package:multiple_select/multi_drop_down.dart';
import 'package:multiple_select/multiple_select.dart';

import '../common/resource.dart';

Map taskRange = {
  Resource.planTitleThisYear: [
    {
      'text': '一月',
      'value': 1
    },
    {
      'text': '二月',
      'value': 2
    },
    {
      'text': '三月',
      'value': 3
    },
    {
      'text': '四月',
      'value': 4
    },
    {
      'text': '五月',
      'value': 5
    },
    {
      'text': '六月',
      'value': 6
    },
    {
      'text': '七月',
      'value': 7
    },
    {
      'text': '八月',
      'value': 8
    },
    {
      'text': '九月',
      'value': 9
    },
    {
      'text': '十月',
      'value': 10
    },
    {
      'text': '十一月',
      'value': 11
    },
    {
      'text': '十二月',
      'value': 12
    }
  ],
  Resource.planTitleThisMonth: [
    {
      'text': '第一周',
      'value': 1
    },
    {
      'text': '第二周',
      'value': 2
    },
    {
      'text': '第三周',
      'value': 3
    },
    {
      'text': '第四周',
      'value': 4
    },
    {
      'text': '第五周',
      'value': 5
    }
  ]
};

class TaskDetail extends StatefulWidget {
  TaskDetail({Key key, this.title, this.item}) : super(key: key);

  @required final String title;
  @required final Map item;

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  List _selectedValues = [];

  MultipleDropDown _getTaskRange(List<Map> taskList) {
    List<MultipleSelectItem> dropdownItems = List.generate(
      taskList.length,
      (index) => MultipleSelectItem.build(
        value: taskList[index]['value'],
        display: taskList[index]['text'],
        content: taskList[index]['text'],
      )
    );
    return new MultipleDropDown(
      placeholder: Resource.selectTip,
      disabled: false,
      values: _selectedValues,
      elements: dropdownItems
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    List<Map> taskList = [];
    if (title == Resource.planTitleThisYear
      || title == Resource.planTitleThisMonth) {
      taskList = taskRange[title];
    } else if (title == Resource.planTitleThisWeek) {
      taskList = [];
    }

    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: new AppBar(
          title: new Text('流水账'),
          centerTitle: true,
          backgroundColor: Colors.white70,
          brightness: Brightness.light
        )
      ),
      body: new ListView(
        children: <Widget>[
          new Form(
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    height: 60.0,
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: Resource.taskContentLabel
                      ),
                      controller: TextEditingController.fromValue(TextEditingValue(
                        text: widget.item['value']
                      ))
                    )
                  ),
                  new Container(
                    height: 60.0,
                    child: _getTaskRange(taskList)
                  ),
                  new Container(
                    height: 25.0,
                    margin: EdgeInsets.symmetric(vertical: 40.0),
                    child: new SeekBar(
                      progresseight: 10.0,
                      min: 0,
                      max: 100,
                      value: 75,
                      sectionCount: 4,
                      showSectionText: true
                    )
                  ),
                  new Container(
                    width: 360.0,
                    height: 42.0,
                    child: new RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text(
                        Resource.taskSubmit,
                        style: new TextStyle(
                          fontSize: 18.0
                        )
                      )
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}
