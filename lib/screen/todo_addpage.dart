// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moor/moor.dart' as moor;
import 'package:todo_application_official/database/database.dart';
import 'package:todo_application_official/main.dart';
import 'todo_homepage.dart';

class Addpage extends StatefulWidget {
  Task? task;
  String? type;
  Addpage({Key? key, this.task, this.type}) : super(key: key);

  @override
  _AddpageState createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  //
  String? title;
  String? description;

  final _formvalid = GlobalKey<FormState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  //checks
  checker() {
    if (widget.type == 's') {
      titlecontroller.text = widget.task!.title;
      descriptioncontroller.text = widget.task!.description;
    }
  }

  //calling method
  @override
  void initState() {
    checker();
    super.initState();
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //center title is a property which fix the title in the center.
        centerTitle: true,
        backgroundColor: Colors.purple[800],
        title: Text(
          'Todo',
          style: GoogleFonts.pacifico(fontSize: 35),
        ),
      ),

      //This will make whole values scrollable and it wont cause error
      body: SingleChildScrollView(
        //while keyboards are opened.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Write your Task',
                    style: GoogleFonts.averiaSerifLibre(
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
            ),
            //container ends
            SizedBox(
              height: 10,
            ),

            //Form will strat from here
            Form(
              key: _formvalid,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    // -------------------------title text field---------------------------------
                    child: TextFormField(
                      controller: titlecontroller,
                      onTap: () {
                        FocusScope.of(context)
                            .unfocus(); // This will close on screen keyboard when click on surface.
                      },
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: GoogleFonts.oswald(
                          color: Colors.black,
                        ),
                        hintText: 'Enter your Title',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                      ),
                      onSaved: (value) {
                        title = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the Title';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),

                    //---------------------------Description textfield----------------------------------------------------
                    child: TextFormField(
                      //text form filed
                      controller: descriptioncontroller,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: GoogleFonts.oswald(
                          color: Colors.black,
                        ),
                        hintText: 'Enter your description',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 30.0,
                          horizontal: 20.0,
                        ),
                      ),
                      onSaved: (value) {
                        description = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the Description';
                        } else {
                          return null;
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //-----------------------submit button------------------------
                ElevatedButton(
                    child: Text(widget.type == 's' ? 'Update' : 'Submit'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      if (_formvalid.currentState!.validate()) {
                        _formvalid.currentState!.save();
                        if (widget.type == 's') {
                          var task = TasksCompanion(
                              id: moor.Value(widget.task!.id),
                              title: moor.Value(title!),
                              description: moor.Value(description!));
                          print(task);
                          appDatabase!.updateTask(task);
                        } else {
                          appDatabase!.insertNewTasks(TasksCompanion.insert(
                              title: titlecontroller.text,
                              description: descriptioncontroller.text));
                        }
                        Navigator.pop(context);
                      }
                    }),

                // cancel button----------------------------------------------------
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red[400]),
                  onPressed: () {
                    FocusScope.of(context)
                        .unfocus(); // This close the onscreen keyboard in the screen.
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
