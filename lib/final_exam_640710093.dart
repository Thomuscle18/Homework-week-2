import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String role;
  final String email;
  final String phone;
  final String birthdate;
  final String bloodType;

  const ProfileCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.bloodType,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  void _loadStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _statusController.text = prefs.getString('status') ?? '';
    });
  }

  void _saveStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('status', _statusController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            const SizedBox(height: 10),
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.role,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.blue),
                const SizedBox(width: 5),
                Text(widget.email),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, color: Colors.green),
                const SizedBox(width: 5),
                Text(widget.phone),
              ],
            ),
            const SizedBox(height: 10),
            Text("Birth Date: ${widget.birthdate}",
                style: const TextStyle(fontSize: 14)),
            Text("Blood Type: ${widget.bloodType}",
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveStatus,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 207, 255, 187),
        appBar: AppBar(
          title: const Text('Custom Widget'),
          backgroundColor: const Color.fromARGB(255, 155, 255, 166),
          elevation: 0,
        ),
        body: Center(
          child: ProfileCard(
            imageUrl:
                'https://imgk.timesnownews.com/story/TomandJerry.PNG?tr=w-1200,h-900',
            name: 'Wachiravit Namjaisuk',
            role: 'Student',
            email: 'namjaisuk_w@silpakorn.edu',
            phone: '0940042605',
            birthdate: '18 May 2002',
            bloodType: 'O',
          ),
        ),
      ),
    );
  }
}
