import 'package:flutter/material.dart';
import 'package:sqlite_database/database/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbHelper _db = DbHelper.getInstance;
  @override
  void initState() {
    _db.getDB;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes List'), centerTitle: true),
      body: FutureBuilder(
        future: _db.fetchNote(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('No Notes available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index]['title'].toString() ?? ''),
                  subtitle: Text(
                    snapshot.data?[index]['desc'].toString() ?? '',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
