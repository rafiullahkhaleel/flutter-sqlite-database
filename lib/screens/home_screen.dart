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
      appBar: AppBar(
        title: const Text('Notes List'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

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
                  title: Text(
                    snapshot.data?[index][DbHelper.noteTitle].toString() ?? '',
                  ),
                  subtitle: Text(
                    snapshot.data?[index][DbHelper.noteDesc].toString() ?? '',
                  ),
                  trailing: Text(
                    snapshot.data?[index][DbHelper.sNo].toString() ?? '',
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text('Add Notes'),
                content: Column(
                  mainAxisSize: .min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                contentPadding: .all(10),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(onPressed: (){}, child: Text('Add'))
                ]
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
