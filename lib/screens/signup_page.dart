import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in_all/google_sign_in_all.dart';

import '../services/shared.dart';
import '../models/user.dart';
import './biometric_page.dart';
import '../keys.dart';

class LoginPage extends HookWidget {
  String id = '', name = '', token = '';

  @override
  Widget build(BuildContext context) {
    final signIn = useMemoized(
      () => setupGoogleSignIn(
        scopes: [
        ],
        webClientId: Keys.webAPIKey,
      ),
    );

    final accessToken = useState('');
    final username = useState('');
    final userid = useState('');

    final onSignIn = () async {
      final credentials = await signIn.signIn();
      final user = await signIn.getCurrentUser();

      accessToken.value = credentials.accessToken;
      username.value = user.displayName;
      userid.value = user.id;

      Shared.storeUser(
        User(
          userId: user.id,
          userName: user.displayName,
          token: credentials.accessToken,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BiometricPage(),
        ),
      );
    };

    return Scaffold(
      backgroundColor: Color(0xfff39c11),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Image.asset('assets/SignupPage.png'),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Cura',
                      style:
                      //GoogleFonts.getFont('Rounded Mplus'),
                      TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        //color: Colors.black
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
              ),
              child: RaisedButton(
                onPressed: () {
                  onSignIn();
                },
                //color: Color(0xff1ABC9C),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text(
                  'Continue With Google',
                  style: TextStyle(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(
                    color: Color(0xff1ABC9C),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
