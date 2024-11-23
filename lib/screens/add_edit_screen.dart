import 'package:flutter/material.dart';
import '../models/tanaman.dart';
import 'package:uuid/uuid.dart';

class AddEditScreen extends StatefulWidget {
  final Plant? existingPlant;
  final Function(Plant) onSave;

  AddEditScreen({this.existingPlant, required this.onSave});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaSpesiesController = TextEditingController();
  final _namaIndonesiaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _gambarController = TextEditingController();

  @override
  void initState() {
    if (widget.existingPlant != null) {
      _namaSpesiesController.text = widget.existingPlant!.namaSpesies;
      _namaIndonesiaController.text = widget.existingPlant!.namaIndonesia;
      _deskripsiController.text = widget.existingPlant!.deskripsi;
      _gambarController.text = widget.existingPlant!.gambar;
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingPlant == null ? 'Menambah Data Tanaman' : 'Edit Data Tanaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaSpesiesController,
                decoration: InputDecoration(labelText: 'Nama Spesies'),
                validator: (value) => value!.isEmpty ? 'Masukkan Nama Spesies' : null,
              ),
              TextFormField(
                controller: _namaIndonesiaController,
                decoration: InputDecoration(labelText: 'Nama Indonesia'),
                validator: (value) => value!.isEmpty ? 'Masukkan Nama Indonesia' : null,
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) => value!.isEmpty ? 'Masukkan Deskripsi' : null,
              ),
              TextFormField(
                controller: _gambarController,
                decoration: InputDecoration(labelText: 'Gambar Tanaman'),
                validator: (value) => value!.isEmpty ? 'Masukkan URL Gambar Tanaman' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final id = widget.existingPlant?.id ?? Uuid().v4();
                    final newPlant = Plant(
                      id: id,
                      namaSpesies: _namaSpesiesController.text,
                      namaIndonesia: _namaIndonesiaController.text,
                      deskripsi: _deskripsiController.text,
                      gambar: _gambarController.text,
                    );
                    widget.onSave(newPlant);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
