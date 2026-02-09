import 'package:flutter/material.dart';
import '../services/flower_service.dart';
import '../models/flower.dart';

class ListFlowerScreen extends StatefulWidget {
  ListFlowerScreenState createState() => ListFlowerScreenState();
}

class ListFlowerScreenState extends State<ListFlowerScreen> {
  List<Flower> flowers = [];

  void loadFlowers() async {
    await FlowerService.getFlowers().then(
      (value) => {
        setState(() {
          flowers = List<Flower>.from(value);
        }),
      },
    );
  }

  void initState() {
    super.initState();
    loadFlowers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flower List')),
      body: ListView.builder(
        itemCount: flowers.length,
        itemBuilder: (context, index) {
          Flower flower = flowers[index];
          return ListTile(
            title: Text(flower.name),
            subtitle: Text(flower.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.visibility), 
                  onPressed: () {
                    Navigator.of(context).pushNamed('/view_flower.dart', arguments: flower);
                  }),

                IconButton(
                  icon: Icon(Icons.edit), 
                  onPressed: () {
                    Navigator.of(context).pushNamed('/edit_flower.dart', arguments: flower);
                  }),

                IconButton(
                  icon: Icon(Icons.delete), 
                  onPressed: () {
                    Navigator.of(context).pushNamed('/delete_flower.dart', arguments: flower);
                  }),
              ],
            ),
          );
        },
      ),
    );
  }
}
