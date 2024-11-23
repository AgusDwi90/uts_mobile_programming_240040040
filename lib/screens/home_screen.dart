import 'package:flutter/material.dart';
import '../models/tanaman.dart';
import 'add_edit_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> savePlantsToStorage(List<Plant> plants) async {
  final prefs = await SharedPreferences.getInstance();
  final plantListJson = plants.map((plant) => jsonEncode(plant.toJson())).toList();
  await prefs.setStringList('plants', plantListJson);
}

Future<List<Plant>> loadPlantsFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final plantListJson = prefs.getStringList('plants') ?? [];
  return plantListJson.map((plantJson) {
    return Plant.fromJson(jsonDecode(plantJson));
  }).toList();
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Plant> _plants = [];

  void _addPlant(Plant plant) {
    setState(() {
      _plants.add(plant);
      savePlantsToStorage(_plants); // Panggil metode global
    });
  }

  void _editPlant(String id, Plant updatedPlant) {
    setState(() {
    final index = _plants.indexWhere((plant) => plant.id == updatedPlant.id);
    if (index != -1) {
      _plants[index] = updatedPlant;
      savePlantsToStorage(_plants); // Simpan ke SharedPreferences
    }
    });
  }

  void _deletePlant(String id) {
    setState(() {
      _plants.removeWhere((plant) => plant.id == id);
      savePlantsToStorage(_plants);
    });
  }

  @override
  void initState() {
    super.initState();
      loadPlantsFromStorage().then((loadedPlants) {
        setState(() {
      _plants.addAll(loadedPlants);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Tumbuhan'),
      ),
      body: _plants.isEmpty
          ? Center(child: Text('Belum ada data tumbuhan!'))
          : ListView.builder(
              itemCount: _plants.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: Image.network(_plants[i].gambar, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(_plants[i].namaIndonesia),
                subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_plants[i].namaSpesies, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    _plants[i].deskripsi,
                style: TextStyle(color: Colors.grey, fontSize: 12),
                maxLines: 2, // Batasi jumlah baris jika deskripsi panjang
                overflow: TextOverflow.ellipsis, // Tambahkan '...' jika teks terlalu panjang
                ),
              ],
            ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => AddEditScreen(
                              existingPlant: _plants[i],
                              onSave: (updatedPlant) => _editPlant(_plants[i].id, updatedPlant),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deletePlant(_plants[i].id),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => AddEditScreen(
                onSave: _addPlant,
              ),
            ),
          );
        },
      ),
    );
  }
}
