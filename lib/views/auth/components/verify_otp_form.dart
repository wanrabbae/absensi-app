import 'package:app/global_resource.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app/global_resource.dart';

class OTPForm extends StatefulWidget {
  final s;

  OTPForm({required this.s});
  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  Duration _timerDuration = Duration(minutes: 5); // 5 minutes
  bool _isTimerRunning = false;

  void startTimer() {
    if (_isTimerRunning) return;
    _isTimerRunning = true;

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timerDuration.inSeconds > 0) {
          _timerDuration -= Duration(seconds: 1);
        } else {
          _isTimerRunning = false;
          timer.cancel();
        }
      });
    });
  }

  void resendOTP() {
    // TODO: Implement the logic for resending OTP here
    // This method will be called when the "Resend OTP" button is pressed.
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTimer =
        '${_timerDuration.inMinutes.remainder(60)}:${(_timerDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Kode OTP",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: TextFormField(
                  onChanged: (value) {
                    widget.s.otpForm = value;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    suffix: Text(
                      formattedTimer,
                      style: TextStyle(color: colorBluePrimary),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorBluePrimary, width: 2)),
                    contentPadding: const EdgeInsets.only(left: 5),
                    hintText: "Masukkan 6 angka kode",
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 20),
          child: Text(
            "Temukan 6 angka kode OTP pada kotak masuk e-mail anda.",
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}

Widget formData(s, context) {
  return OTPForm(s: s);
}
