import 'package:curd_flutter/models/user.dart';
import 'package:curd_flutter/provider/users.dart';
import 'package:curd_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatefulWidget {

  final User user;

  const UserTile(this.user);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {

    final avatar = widget.user.avatarUrl.isEmpty
      ? CircleAvatar(child: Icon(Icons.person)) 
      : CircleAvatar(backgroundImage: NetworkImage(widget.user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(widget.user.name),
      subtitle: Text(widget.user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: widget.user,);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () { 
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Color.fromRGBO(70, 70, 100, 0.5),
                    title: Text('Excluir usuário', 
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    content: Text('Tem certeza'),
                    actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Yes'),
                        ),
                    ],
                  )).then((confirmed) => {
                    if (confirmed) {
                      Provider.of<Users>(context, listen: false).remove(widget.user.id)
                    }
                  });
                },
            )
          ],
        ),
      ),
    );
  }
}