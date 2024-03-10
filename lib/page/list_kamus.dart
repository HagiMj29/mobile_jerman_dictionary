import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_jerman_dictionary/page/detail_page.dart';
import '../model/listdirectiory_model.dart';

class ListKamus extends StatefulWidget {
  const ListKamus({super.key});

  @override
  State<ListKamus> createState() => _ListKamusState();
}

class _ListKamusState extends State<ListKamus> {
  List<Result> kamusList = [];
  List<Result> searchResults = [];
  TextEditingController controller = TextEditingController();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(scrollListener);
    fetchKamus();
  }

  Future<void> fetchKamus() async {
    try {
      final response = await http.get(Uri.parse("http://127.0.0.1:8000/api/dictionary"));
      final data = listKamusFromJson(response.body);
      setState(() {
        kamusList = data.results;
        searchResults = kamusList;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  void searchKamus(String query) {
    setState(() {
      searchResults = kamusList
          .where((result) =>
      result.kataJerman.toLowerCase().contains(query.toLowerCase()) ||
          result.kataIndonesia.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Reach the bottom, load more data
      // Implement the logic to fetch more data from the API here
      // For now, let's just fetch the data again for demonstration
      fetchKamus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blue[100],
        actions: [
          Image.asset("image/logo.png", height: 50,),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: searchKamus,
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: searchResults.length + 1,
              itemBuilder: (context, index) {
                if (index < searchResults.length) {
                  Result data = searchResults[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailKamus(data),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "${data.kataJerman}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${data.kataIndonesia}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // Loading indicator
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
