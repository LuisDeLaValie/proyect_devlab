import 'package:flutter/material.dart';
import 'package:proyect_devlab/api/github_api.dart';
import 'package:proyect_devlab/model/github_models/repositorio_model.dart';
import 'package:proyect_devlab/services/manejo_archivos_services.dart';
import 'package:proyect_devlab/ui/page/home/widgets/items_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: createproyect,
          ),
        ],
      ),
      body: FutureBuilder(
        future: getrepos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<dynamic, dynamic>>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
              itemCount: snapshot.data?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (_, index) => ItemsCards(
                repo: RepositorioModel.fromMap(
                  Map<String, dynamic>.from(snapshot.data![index]),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Map<dynamic, dynamic>>?> getrepos() async {
    try {
      var res = (await GithubApi().get('/user/repos')) as List<dynamic>;
      var list = res.map((e) => Map<dynamic, dynamic>.from(e)).toList();
      return list;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> createproyect() async {
    ManejoArchivosServices().iniciarProyecto();
  }
}
