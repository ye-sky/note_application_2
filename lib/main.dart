import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textFieldController = TextEditingController();
  List<String> savedTexts = [];
  bool isTextFieldVisible = false;
  FocusNode _textFieldFocus = FocusNode();

  @override
  void dispose() {
    _textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Square Text Field Example'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Visibility(
            visible: isTextFieldVisible,
            child: Center(
              child: Container(
                width: 200,
                height: 20,
                //decoration: BoxDecoration(
                //border: Border.all(),
                //),
                child: TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    hintText: 'Enter text',
                  ),
                  autofocus: true,
                  focusNode: _textFieldFocus,
                  onSubmitted: (String value) {
                    // Save the entered text when Enter is pressed
                    _saveText();
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: savedTexts.length,
              itemBuilder: (context, index) {
                return _buildListItem(savedTexts[index], index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isTextFieldVisible = !isTextFieldVisible;
            if (isTextFieldVisible) {
              _textFieldFocus.requestFocus();
            } else {
              // Save the entered text when the floating action button is pressed
              _saveText();
            }
          });
        },
        child: Icon(isTextFieldVisible ? Icons.save : Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _saveText() {
    String enteredText = _textFieldController.text;
    if (enteredText.isNotEmpty) {
      setState(() {
        savedTexts.add(enteredText);
        _textFieldController.clear();
        isTextFieldVisible = false;
      });
    }
  }

  Widget _buildListItem(String text, int index) {
    return ListTile(
      title: Text(text),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _deleteText(index);
        },
      ),
    );
  }

  void _deleteText(int index) {
    setState(() {
      savedTexts.removeAt(index);
    });
  }
}
