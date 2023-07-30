import 'package:app/global_resource.dart';

import 'dart:async';
import 'package:flutter/material.dart';

class OTPForm extends StatefulWidget {
  final s;

  OTPForm({required this.s});
  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  Duration _timerDuration = Duration(minutes: 5); // 5 minutes
  bool _isTimerRunning = false;
  Timer? _timer;

  void startTimer() {
    if (_isTimerRunning) return;
    _isTimerRunning = true;

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
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
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTimer =
        '${_timerDuration.inMinutes.remainder(60)}:${(_timerDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Kode OTP",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: TextFormField(
                  onChanged: (value) {
                    widget.s.otpForm = value;
                  },
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    suffix: Text(
                      formattedTimer,
                      style: TextStyle(
                          color: colorBluePrimary, fontWeight: FontWeight.w500),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorBluePrimary, width: 2)),
                    hintText: "Masukkan 6 angka kode",
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Temukan 6 angka kode OTP pada kotak masuk e-mail anda.",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget formData(s, context) {
  return OTPForm(s: s);
}
