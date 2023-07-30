import 'dart:convert';
import 'package:bit_rupee/views/Login_page.dart';
import 'package:bit_rupee/views/Send_money.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  // Future<Post> fetchPost() async{
  //   final uri =Uri.parse("http://172.16.2.222:8080/bitrupee/api/wutxo/7");
  //   final response=await http.get(uri);
  //   if(response.statusCode==200){
  //     return Post.fromJson(json.decode(response.body));
  //   }
  //   else{
  //     throw Exception('Failed to load post');
  //   }
  // }

//  Future<Post> createPost(String id) async{
//   Map<String, dynamic> request={
//     'userId': "1"
//   };
 
// final uri= Uri.parse("https:jasonplaceholder.typicode.com/posts");
// final response=await http.post(uri, body: request);
// if(response.statusCode==201){
//       return Post.fromJson(json.decode(response.body));
//     }
//     else{
//       throw Exception('Failed to load post');
//     }
//  }
}