import 'package:first_app/component/custom_profile_card.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Widget'),
        centerTitle: true,
        ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomProfileCard(name: 'Tung', position: 'Doctor/Manager/Commander/Master', email: 'Prasertomboon_t@su.ac.th', phoneNumber: '081-123-9973', imageUrl: 'https://tse1.mm.bing.net/th/id/OIP.AlYBc525r7AfX8Sa-EwDrQHaFj?cb=12&rs=1&pid=ImgDetMain&o=7&rm=3')
          ],
        ),
      ),
    );
  }
}
