import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  late final TextEditingController controller;
  bool codeSent = false;
  String? verificationId;
  int? resendToken;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: !codeSent
              ? Column(
                  children: [
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          sendOTP(controller.text);
                        }
                      },
                      child: Text('Send OTP'),
                    ),
                  ],
                )
              : Column(
                  children: [
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Verification Code',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          verifyOTP(controller.text);
                        }
                      },
                      child: Text('Verify'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> sendOTP(phone) async {
    setState(() {
      loading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          loading = false;
        });
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Invalid Phone',
              ),
            ),
          );
        }
      },
      codeSent: (String vId, int? token) async {
        controller.text = '';

        setState(() {
          loading = false;
          codeSent = true;
        });

        verificationId = vId;
        resendToken = token;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOTP(String code) async {
    setState(() {
      loading = true;
    });
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: code);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (_) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
