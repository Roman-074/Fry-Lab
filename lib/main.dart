// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:fry_lab/sendMessage.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("FryLab mini App"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: messageController,
//               decoration: const InputDecoration(
//                   hintText: 'Enter your message',
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(32.0))),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//                       borderRadius: BorderRadius.all(Radius.circular(32.0))),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 2.0),
//                       borderRadius: BorderRadius.all(Radius.circular(32.0)))),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
//                 backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
//                 shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               onPressed: () {
//                 if (messageController.text != null) {
//                   sendMessageToTg(messageController.text);
//                 }
//               },
//               child: Text("Send"),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'dart:js' as js;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Mini App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userName;
  String? userUsername;

  @override
  void initState() {
    super.initState();
    _initializeTelegram();
  }

  void _initializeTelegram() {
    var tg = js.context['Telegram']['WebApp'];
    tg.callMethod('ready');

    // Получаем информацию о пользователе
    var user = js.context['Telegram']['WebApp']['initDataUnsafe']['user'];
    setState(() {
      userName = user['first_name'];
      userUsername = user['username'];
    });

    // Настраиваем главную кнопку
    tg['MainButton']['text'] = 'Send Data';
    tg['MainButton'].callMethod('show');
    tg['MainButton'].callMethod('onClick', [() {
      tg.callMethod('sendData', ['Hello from Flutter!']);
    }]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Telegram Mini App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (userName != null && userUsername != null) ...[
              Text('Hello, $userName!', style: TextStyle(fontSize: 24)),
              Text('Your username is @$userUsername', style: TextStyle(fontSize: 18)),
            ] else
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
