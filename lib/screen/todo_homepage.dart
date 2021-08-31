import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application_official/database/database.dart';
import 'package:todo_application_official/main.dart';
import 'package:todo_application_official/screen/todo_addpage.dart';

class Homepage extends StatefulWidget {
  // bool isEdit = false;

  @override
  _HomepageState createState() {
    return new _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  Stream<List<Task>>? watch;

  @override
  void initState() {
    //call method
    watch = appDatabase!.watchAllTask();
    super.initState();
  }

  // int get taskcount{
  //   return
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple[800],
        title: Text(
          'Todo',
          style: GoogleFonts.pacifico(fontSize: 35),
        ),
      ),
      // -----------------------------Main Body part covered with single child scroll widget so that when scrolled everying will scroll------------------
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text(''),
            StreamBuilder<List<Task>>(
              initialData: [],
              stream: watch,
              builder: (context, snapshot) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 300, horizontal: 0),
                      child: Container(
                        child: Text(
                          'You don\'t have any Task',
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: snapshot.data!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        //-------------Added Slidable feature from which we can edit and delete the items.
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              //Giving box shadow
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              // Listtile starts from here
                              title: Text(
                                e.title, // e.title is the title shown in the home page
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                  e.description, //e.description is the description shown in the homepage.
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                  )),
                              trailing: IconButton(
                                onPressed: () {
                                  print(e);
                                  // appDatabase!.updateTask(e);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Addpage(
                                        task: e,
                                        type: 's',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.green,
                              ),
                            ),
                          ),
                          //Action- back slidable delete
                          secondaryActions: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: IconSlideAction(
                                caption: 'Delete',
                                // color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  appDatabase!
                                      .deleteTask(e.id); //delete the task
                                },
                                foregroundColor: Colors.red,
                              ),
                            ),
                          ],
                          //Action- front slidable update
                          // actions: [
                          //   Padding(
                          //     padding: const EdgeInsets.all(12.0),
                          //     child: IconSlideAction(
                          //       caption: 'Update',
                          //       // color: Colors.green,
                          //       icon: Icons.edit,
                          //       foregroundColor: Colors.green,
                          //       onTap: () {
                          //         appDatabase!.updateTask(e);
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => Addpage()),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ],
                        ),
                      );
                    }).toList(),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      // --------------------------------Drawer------------------
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.black87, Colors.purple]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage: AssetImage('images/pranjal.jpg'),
                      ),
                    ),
                  ),
                  Text(
                    'Pranjal Piya',
                    style: GoogleFonts.oswald(
                      fontSize: 25.0,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Email: pranjalpiya10@gmail.com',
                      style: GoogleFonts.courgette(
                          fontSize: 12.0, color: Colors.white)),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: '',
                    fontSize: 17.0,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.task),
                title: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                onTap: () {
                  // what this does is, it will first close the drawer and go to the addpage.
                  // the reason for this is for better UX.
                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Addpage()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              child: ListTile(
                title: Text(
                  'Help and Feedback',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                leading: Icon(Icons.help),
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                onTap: () {
                  // SystemNavigator.pop();  // thos line of code just exits the whole app.
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          title: Text('Do you really wanna Exit ?'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                            ),
                            FlatButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Divider(),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Text(
                ' \u00a9 Developed by Pranjal Piya',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),

      //floating action button
      floatingActionButton: FloatingActionButton(
        child:
            // Text('Add'),
            Icon(Icons.add),
        backgroundColor: Colors.purple[800],
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpage()),
          );
        },
      ),
    );
  }
}
