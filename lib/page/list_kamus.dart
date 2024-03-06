import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/listdirectiory_model.dart';

class ListKamus extends StatefulWidget {
  const ListKamus({super.key});

  @override
  State<ListKamus> createState() => _ListKamusState();
}

class _ListKamusState extends State<ListKamus> {

  Future<List<Result>?> getKamus() async {
    try {
      http.Response res = await http.get(
          Uri.parse("http://127.0.0.1:8000/api/dictionary"));
      return listKamusFromJson(res.body).results;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome", style: TextStyle(
          color: Colors.black,
        ),),
        backgroundColor: Colors.blue[100],
        actions: [
          Image.asset("image/logo.png", height: 50,)
        ],
      ),
      body: FutureBuilder(
        future: getKamus(),
        builder: (BuildContext context, AsyncSnapshot<List<Result>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Result? data = snapshot.data?[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text("${data?.kataJerman}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              subtitle: Text("${data?.kataIndonesia}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black54
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        },
      ),
    );
  }
}

