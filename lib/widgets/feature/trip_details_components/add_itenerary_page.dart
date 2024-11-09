import 'package:flutter/material.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class AddIteneraryPage extends StatefulWidget {
  const AddIteneraryPage({super.key});

  @override
  State<AddIteneraryPage> createState() => _AddIteneraryPageState();
}

class _AddIteneraryPageState extends State<AddIteneraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
        title: CustomText(
          text: 'Create Itinerary'
          
        ),
        actions: [
            TextButton(
                onPressed: () {
                 
                },
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(width: 10),
          ],
      ),
    );
  }
}
