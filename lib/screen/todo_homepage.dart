import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application_official/database/database.dart';
import 'package:todo_application_official/main.dart';
import 'package:todo_application_official/screen/todo_addpage.dart';

class Homepage extends StatefulWidget {
  // final titleHolder;
  // final descriptionHolder;

  // Homepage({
  //   Key? key,
  //   this.titleHolder,
  //   this.descriptionHolder,
  // }) : super(key: key);
  @override
  _HomepageState createState() {
    return new _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  Stream<List<Task>>? watch;

  @override
  void initState() {
    watch = appDatabase!.watchAllTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Padding(
          padding: const EdgeInsets.only(left: 70, right: 0),
          child: Text(
            'Todo',
            style: GoogleFonts.pacifico(fontSize: 35),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<Task>>(
              initialData: [],
              stream: watch,
              builder: (context, snapshot) {
                if (snapshot.data!.length == 0) {
                  return Text(
                    '',
                  );
                }
                if (snapshot.hasData) {
                  return ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: snapshot.data!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(7.0),
                        //-------------Added Slidable feature from which we can edit and delete the items.
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              // Listtile starts from here
                              title: Text(
                                e.title,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(e.description,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                  )),
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
                                  appDatabase!.deleteTasks(e);
                                },
                                foregroundColor: Colors.red,
                              ),
                            ),
                          ],
                          //Action- front slidable update
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: IconSlideAction(
                                caption: 'Update',
                                color: Colors.green,
                                icon: Icons.edit,
                                foregroundColor: Colors.white,
                                onTap: () {
                                  appDatabase!.updateTask(e);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Addpage()),
                                  );
                                },
                              ),
                            ),
                          ],
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
                gradient: LinearGradient(colors: [Colors.black87, Colors.red]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 35.0,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                    // TextStyle(

                    //   fontFamily: 'Oswald',
                    //   fontSize: 35.0,
                    //   color: Colors.white,
                    //   letterSpacing: 1.0,
                    // ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Email: pranjalpiya10@gmail.com',
                      style: GoogleFonts.courgette(
                          fontSize: 17.0, color: Colors.white)
                      // TextStyle(
                      //   fontSize: 20.0,
                      //   fontFamily: 'Courgette',
                      //   color: Colors.white,
                      // ),
                      ),
                  SizedBox(
                    height: 15.0,
                  )
                ],
              ),
            ),
            ListTile(
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
            ListTile(
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
            SizedBox(
              height: 30.0,
            ),
            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text(
            //     'Setting',
            //     style: TextStyle(
            //       fontSize: 17.0,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.logout_outlined),
            //   title: Text(
            //     'Logout',
            //     style: TextStyle(
            //       fontSize: 17.0,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        ),
      ),

      //floating action button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
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
