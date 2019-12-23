import 'package:flutter/material.dart';
import './common/resource.dart';

class TaskButton extends StatelessWidget {
  @required final String btnContent;
  // @required final Function callback;
  final Color backColor;

  TaskButton(this.btnContent, {this.backColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: 1.0,
      child: new FlatButton(
        color: backColor,
        onPressed: () {
          // callback();
        },
        child: new Text(
          btnContent,
          style: new TextStyle(
            color: Colors.white,
            fontSize: 15.0
          )
        ),
      )
    );
  }
}

class Task extends StatefulWidget {
  Task({Key key, this.content}) : super(key: key);
    
  final String content;

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.symmetric(vertical: 2.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: BorderSide(width: 1.0, color: Colors.cyan),
          bottom: BorderSide(width: 1.0, color: Colors.cyan),
        )
      ),
      height: 45.0,
      child: new Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            flex: 3,
            child: new Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                widget.content,
                style: new TextStyle(
                  fontSize: 16.0
                )
              )
            )
          ),
          new Expanded(
            flex: 1,
            child: new TaskButton(Resource.edit, backColor: Colors.green)
          ),
          new Expanded(
            flex: 1,
            child: new TaskButton(Resource.delete)
          )
        ],
      )
    );
  }
}