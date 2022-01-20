import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mychat/allConstants/constants.dart';
import 'package:mychat/allModels/popup_choices.dart';
import 'package:mychat/allProvider/auth_provider.dart';
import 'package:mychat/allScreens/login_page.dart';
import 'package:mychat/allScreens/settings_page.dart';
import 'package:mychat/main.dart';
import 'package:provider/src/provider.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScarollController = ScrollController();

  int _limit = 20;
  int _limentIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late String currentUserId;
  late AuthProvider authProvider;
  // late HomeProvider homeProvider;

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: "Settings", icon: Icons.settings),
    PopupChoices(title: "Sign out", icon: Icons.exit_to_app),
  ];

  Future<void> handleSignOut() async {
    authProvider.handleSignOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void scrollListener(){
    if(listScarollController.offset >= listScarollController.position.maxScrollExtent && !listScarollController.position.outOfRange){
      setState(() {
        _limit += _limentIncrement; 
      });
    }
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == "Sign out") {
      handleSignOut();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.grey,
        ),
        onSelected: onItemMenuPress,
        itemBuilder: (BuildContext context) {
          return choices.map((PopupChoices choice) {
            return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: [
                  Icon(
                    choice.icon,
                    color: ColorConstants.primaryColor,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    choice.title,
                    style: const TextStyle(color: ColorConstants.primaryColor),
                  )
                ],
              ),
            );
          }).toList();
        });
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    // homeProvider = context.read<HomeProvider>();

    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
    listScarollController.addListener(scrollListener);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        leading: IconButton(
          icon: Switch(
            value: isWhite,
            onChanged: (value) {
              setState(() {
                isWhite = value;
                print(isWhite);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black45,
          ),
          onPressed: () => "",
        ),
        actions: [
          buildPopupMenu(),
        ],
      ),
    );
  }
}
