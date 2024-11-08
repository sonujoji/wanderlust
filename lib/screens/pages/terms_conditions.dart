import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:wanderlust/utils/colors.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        foregroundColor: white,
        backgroundColor: primaryColor,
        title: Text(
          "Terms & Conditions",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then(
                (value) {
                  return rootBundle
                      .loadString('assets/images/terms_conditions.md');
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data!,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(color: Colors.white),
                      h1: TextStyle(color: Colors.white),
                      h2: TextStyle(color: Colors.white),
                      h3: TextStyle(color: Colors.white),
                      h4: TextStyle(color: Colors.white),
                      h5: TextStyle(color: Colors.white),
                      h6: TextStyle(color: Colors.white),
                      listBullet: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
