import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeScreeen extends StatefulWidget {
  const HomeScreeen({Key? key}) : super(key: key);

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {

  List<Photos> photos_list = [];
  Future<List<Photos>> getPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200)
    {
      for(Map i in data)
      {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id'] );
        photos_list.add(photos);
      }
      return photos_list;
    }
    else
    {
      return photos_list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              FutureBuilder(
                  future: getPhotos(),
                  builder: (context,AsyncSnapshot<List<Photos>> snapshot){
                    return Expanded(
                      child: ListView.builder(
                          itemCount: photos_list.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                              ),
                              subtitle: Text(snapshot.data![index].title.toString()),
                              title: Text('Note: ' + snapshot.data![index].id.toString()),
                            );
                          }
                      ),
                    );
                  }),
            ],
          ),
        ),
    );

  }
}

class Photos
{
  String title,url;
  int id;
  Photos({required this.title,required this.url,required this.id});
}
