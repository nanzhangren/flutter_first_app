import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../common/resource.dart';

class TaskItem extends StatefulWidget {
  TaskItem({Key key, this.items}) : super(key: key);

  @required final List<Map> items;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Color backColor = Colors.white;

  void markDone() {
    setState(() {
      if (backColor == Colors.white) {
        backColor = Colors.red;
      } else {
        backColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _items = widget.items;
    final SlidableController _slidableController = new SlidableController();

    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final tempItem = _items[index];
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
              title: Text(tempItem['value'])
            )
          ),
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: Resource.edit,
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                //
              }
            ),
            new IconSlideAction(
              caption: tempItem['done'] ? Resource.done : Resource.doing,
              color: Colors.grey,
              icon: tempItem['done'] ? Icons.mood : Icons.mood_bad,
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
