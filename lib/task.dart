import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './common/resource.dart';

class Task extends StatefulWidget {
  Task({Key key, this.items}) : super(key: key);

  @required final List<String> items;

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
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
              title: Text(_items[index])
            )
          ),
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: Resource.edit,
              color: Colors.green,
              icon: Icons.edit,
              onTap: () => {
                //
              }
            ),
            new IconSlideAction(
              caption: Resource.done,
              color: Colors.grey,
              icon: Icons.done,
              onTap: () => {
                //
              }
            )
          ],
          controller: _slidableController
        );
      }
    );
  }
}
