import 'package:flutter/material.dart';

class TranscriptScreen extends StatelessWidget {
  final String transcript;

  TranscriptScreen(this.transcript);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Earnings Call Transcript"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(transcript),
        ),
      ),
    );
  }
}
