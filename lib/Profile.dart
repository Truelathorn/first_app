import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24), // มุมโค้ง
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0, 10),
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: Image.asset(
                      "background.jpg",
                      height: 350,
                      width: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TrueBeater',
                          style: TextStyle(
                            fontSize: 32, // ขนาดใหญ่
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // อยู่ตรงกลาง
                        ),
                        Text(
                          'ชื่อ-นามสกุล : นายตลธร ประเสริฐสมบูรณ์',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'เลขประจำตัว : 650710690',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'สาขาวิชา : คณะวิทยาศาสตร์ สาขาเทคโนโลยีสารสนเทศ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'คำโปรย : นอนไม่ค่อยหลับ สติไม่ค่อยดี หลับตาทุกทีทำไมเห็นแต่เธอ \nเป็นคนที่เงียบๆ ชิวๆ แน่ใช้ชีวิตตามความรู้สึกเรื่อยๆ ไม่ค่อยชอบความกดดันหรือซีเรียสเท่าไหร่',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
