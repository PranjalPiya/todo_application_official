import 'package:flutter/material.dart';
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
        title: Center(
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
                  return Text('the list is empty');
                }
                if (snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: snapshot.data!.map((e) {
                      return ListTile(
                        title: Text(e.title),
                        subtitle: Text(e.description),
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
