
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import './signin_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example App',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Container(
          child:Text("Something went wrong please try again later"),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example App',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Container(
          child:Text("Loading please wait we will get back to you in a while"),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.black,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Robotics Club @ Sastra'),
    );
  }
}

class FirstRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open Route'),
          onPressed: (){
            //Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("RCS"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
//mahathi-modification-1
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              )),

              TextFormField(decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Email-id',
                labelText: 'Email-id*',
              )),

              TextFormField(decoration: const InputDecoration(
                icon: Icon(Icons.school),
                hintText: 'University',
                labelText: 'University*',
              )),
              TextFormField(decoration: const InputDecoration(
                icon: Icon(Icons.book),
                hintText: 'Branch',
                labelText: 'Branch*',
              )),
              TextFormField(decoration: const InputDecoration(
                icon: Icon(Icons.perm_identity),
                hintText: 'Your University roll number',
                labelText: 'Registration Number *',
              )),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'enter your password here',
                  labelText: 'Create Password*',
                ),
                autofocus: false,
                obscureText: true,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password*',
                ),
                autofocus: false,
                obscureText: true,
              ),
              FlatButton(color: Colors.black,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {Text('you have successfully signed up');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstRoute()),
                );},
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
//mahathi-modifcation-1
        ),
      ),
    );
  }
}
//modification-vasavi-1
class FourthRoute extends StatelessWidget{
  @override
  _launchURL() async {
    const url = 'https://medium.com/robotics-club-sastra';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("RCS"),
      ),

      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              FlatButton(color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> FifthRoute()),
                    );
                  },
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 20.0),
                  )
              ),
              Text(
                  '\n'
              ),
              FlatButton(color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> SixthRoute()),
                    );
                  },
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontSize: 20.0),
                  )
              ),
              Text(
                  '\n'
              ),
              FlatButton(color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> SeventhRoute()),
                    );
                  },
                  child: Text(
                    "Projects",
                    style: TextStyle(fontSize: 20.0),
                  )
              ),
              Text(
                  '\n'
              ),
              FlatButton(color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: _launchURL,
                  child: Text(
                    "Blogs",
                    style: TextStyle(fontSize: 20.0),
                  )
              ),
              Text(
                  '\n'
              ),
              FlatButton(color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> NinethRoute()),
                    );
                  },
                  child: Text(
                    "Meetings",
                    style: TextStyle(fontSize: 20.0),
                  )
              ),
            ]
        ),
      ),
    );
  }
}
class FifthRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  }
}
class SixthRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  }
}
class SeventhRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  }
}
class EigthRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  }
}
class NinethRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  }
}

//modification-vasavi-1
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Text(
              'Welcome!\n\n'
                  'We are from Robotics Club @ SASTRA, one of tech clubs at SASTRA University, Thanjavur. Our club is full of DIY enthusiasts who take up projects and challenges from fields like Robotics, IoT, 3D Printing, Computer Vision, Machine Learning and many more…..\n\n',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20.0,
            ),
//mahathi-modification-2
            ButtonBar(
              mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                FlatButton(
                  child: Text('Sign In',style: TextStyle(fontSize: 20.0),),
                  color: Colors.black,

                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> SignInPage()),
                  );
                  },
                ),

                FlatButton(
                    child: Text('Sign Up',style: TextStyle(fontSize: 20.0),),
                    color: Colors.black,
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> RegisterPage()),
                    );
                    }
                ),
              ],
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//mahathi-modification-2
