import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application_official/database/database.dart';
import 'package:todo_application_official/main.dart';
import 'todo_homepage.dart';

class Addpage extends StatefulWidget {
  Addpage({Key? key}) : super(key: key);

  @override
  _AddpageState createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  // final _formvalid = GlobalKey<FormState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  // getItemAndNavigate(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => Homepage(
  //                 titleHolder: titlecontroller.text,
  //                 descriptionHolder: descriptioncontroller.text,
  //               )));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 0),
          child: Text(
            'Todo',
            style: GoogleFonts.pacifico(fontSize: 35),
          ),
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
                    'Add your Task',
                    style: GoogleFonts.oswald(fontSize: 25),
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
              // key: _formvalid,
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
                        hintText: 'Enter your Title',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 30.0,
                          horizontal: 20.0,
                        ),
                      ),
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
                        hintText: 'Enter your description',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 30.0,
                          horizontal: 20.0,
                        ),
                      ),
                      // onFieldSubmitted: (value) {
                      //   print("Field value: $value");
                      // },
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
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      setState(() {
                        appDatabase!.insertNewTasks(TasksCompanion.insert(
                            title: titlecontroller.text,
                            description: descriptioncontroller.text));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Homepage()),
                        // );
                        Navigator.pop(context);
                        titlecontroller.clear();
                        descriptioncontroller.clear();
                      });
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
