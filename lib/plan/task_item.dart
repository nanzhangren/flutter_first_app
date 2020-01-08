import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../common/resource.dart';
import './task_detail.dart';

class TaskItem extends StatefulWidget {
  TaskItem({Key key, this.title, this.items}) : super(key: key);

  @required final String title;
  @required final List<Map> items;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final _items = widget.items;
    final SlidableController _slidableController = new SlidableController();

    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final tempItem = _items[index];
        final value = tempItem['value'];
        final done = tempItem['done'];
        return new Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.23,
          child: Container(
            decoration: new BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.3,
                  color: Colors.grey,
                  style: BorderStyle.solid
                )
              )
            ),
            child: ListTile(
              title: Text(value)
            )
          ),
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: Resource.edit,
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new TaskDetail(
                      title: widget.title,
                      item: {
                        'value': 'aaaaaaaa'
                        }
                    )
                  )
                );
              }
            ),
            new IconSlideAction(
              caption: done ? Resource.done : Resource.doing,
              color: done ? Colors.grey : Colors.red,
              icon: done ? Icons.mood : Icons.mood_bad,
              onTap: () {
                setState(() {
                  tempItem['done'] = !tempItem['done'];
                });
              }
            )
          ],
          controller: _slidableController
        );
      }
    );
  }
}
