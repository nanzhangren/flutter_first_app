import 'package:flutter/material.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart' show SeekBar;

import '../common/resource.dart';

class TaskDetail extends StatefulWidget {
  TaskDetail({Key key, this.item}) : super(key: key);

  @required final Map item;

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
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
      body: new Form(
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
                  initialValue: widget.item['value']
                )
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
    );
  }
}
