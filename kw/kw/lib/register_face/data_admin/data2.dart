import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class UserFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').get();

      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      print('User deleted successfully');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}

class UserModel {
  final String id;
  final String name;
  final String nim;
  final String image;

  Uint8List? imageData;

  UserModel({
    required this.id,
    required this.name,
    required this.nim,
    required this.image,
    this.imageData,
  });

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic>? data = doc.data();
    return UserModel(
      id: doc.id,
      name: data?['name'] ?? '',
      nim: data?['nim'] ?? '',
      image: data?['image'] ?? '',
    );
  }

  Future<void> downloadImage() async {
    if (imageData == null) {
      try {
        final response = await http.get(Uri.parse(image));
        if (response.statusCode == 200) {
          imageData = response.bodyBytes;
          print(
              'Image downloaded successfully: ${imageData!.lengthInBytes} bytes');
        } else {
          print(
              'Failed to download image. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error downloading image: $e');
      }
    }
  }
}

class UserListWidget2 extends StatefulWidget {
  const UserListWidget2({super.key});

  @override
  _UserListWidget2State createState() => _UserListWidget2State();
}

class _UserListWidget2State extends State<UserListWidget2> {
  late Future<List<UserModel>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = UserFirestoreService().getUsers();
  }

  void _refreshUsers() {
    setState(() {
      _usersFuture = UserFirestoreService().getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kembali',
        ),
      ),
      body: Stack(
        alignment: FractionalOffset.center,
        children: [
          Column(
            children: [
              Positioned(
                top: 2,
                child: Container(
                  height: 50,
                  width: 320,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/cowok.png'),
                      ),
                      Text(
                        'Dosen Ngajar',
                        style: TextStyle(color: Colors.white),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/cewel.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Data Mahasiswa',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Semua',
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 85),
            child: FutureBuilder<List<UserModel>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: SizedBox(
                          height: 200,
                          child: Image(image: AssetImage('assets/empty.png'))));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return UserContainer(
                        user: snapshot.data![index],
                        onDelete: _refreshUsers,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserContainer extends StatefulWidget {
  final UserModel user;
  final VoidCallback onDelete;

  const UserContainer({
    super.key,
    required this.user,
    required this.onDelete,
  });

  @override
  _UserContainerState createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  late Future<void> _downloadImageFuture;

  @override
  void initState() {
    super.initState();
    _downloadImageFuture = widget.user.downloadImage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _downloadImageFuture,
      builder: (context, snapshot) {
        return Container(
          height: 135,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 106, 215, 189),
                Color.fromARGB(255, 35, 202, 253),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${widget.user.id}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 20, 93, 130),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'fontku'
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Name: ${widget.user.name}',
                      style: const TextStyle(fontFamily: 'fontku',
                          color: Color.fromARGB(255, 247, 223, 4)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Nim: ${widget.user.nim}',
                      style: const TextStyle(fontFamily: 'fontku',
                          color: Color.fromARGB(255, 201, 8, 185)),
                    ),
                  ],
                ),
              ),
              if (widget.user.imageData != null)
                Container(
                  height: 30,
                  child: Image.memory(widget.user.imageData!),
                ),
              const SizedBox(width: 5),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  print('Mahasiswa berhasil dihapus: ${widget.user.id}');
                  _deleteUser(widget.user.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteUser(String userId) async {
    try {
      await UserFirestoreService().deleteUser(userId);
      print('Mahasiswa berhasil dihapus!');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mahasiswa berhasil dihapus!'),
          backgroundColor: Colors.green,
        ),
      );

      widget.onDelete();
    } catch (e) {
      print('Gagal menghapus mahasiswa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus mahasiswa: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
