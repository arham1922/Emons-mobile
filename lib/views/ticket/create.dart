import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(CreatePage());
}

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFDE1F27), Color(0xFFFA913B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text('Create Ticket', style: TextStyle(fontSize: 17)),
        ),
        body: Center(
          child: MyForm(),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _atmIdController = TextEditingController();
  TextEditingController _bankController = TextEditingController();
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _merkController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _serialController = TextEditingController();
  TextEditingController _petugasController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  TextEditingController _dateController = TextEditingController();

  XFile? _selectedImageATM;
  XFile? _selectedImageStruk;
  XFile? _selectedImagePart;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      _dateController.text = formattedDate;
    }
  }

  Future<void> _pickImageATM() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImageATM = pickedFile;
      });
    }
  }

  Future<void> _pickImageStruk() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImageStruk = pickedFile;
      });
    }
  }

  Future<void> _pickImagePart() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePart = pickedFile;
      });
    }
  }

  void _removeImageATM() {
    setState(() {
      _selectedImageATM = null;
    });
  }

  void _removeImageStruk() {
    setState(() {
      _selectedImageStruk = null;
    });
  }

  void _removeImagePart() {
    setState(() {
      _selectedImagePart = null;
    });
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Berhasil"),
          content: Text("Data Berhasil Di Tambahkan"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cancel"),
          content: Text("Data anda gagal ditambahkan !"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 343,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            buildTextField('ID ATM', _atmIdController),
            buildTextField('Bank', _bankController),
            buildTextField('Lokasi', _lokasiController),
            buildTextField('Merk Mesin', _merkController),
            buildTextField('Tipe Mesin', _typeController),
            buildTextField('Serial Number', _serialController),
            buildTextField('Tanggal Pelaksanaan', _dateController, onTap: () => _selectDate(context)),
            buildTextField('Petugas', _petugasController),
            buildTextField('Analisa Perbaikan', _detailController, maxLines: null),
            SizedBox(height: 30),
            buildImageSelector('Foto ATM', _selectedImageATM, _pickImageATM, _removeImageATM),
            SizedBox(height: 30),
            buildImageSelector('Foto Struk', _selectedImageStruk, _pickImageStruk, _removeImageStruk),
            SizedBox(height: 30),
            buildImageSelector('Foto Part', _selectedImagePart, _pickImagePart, _removeImagePart),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('Save', () {
                  print('Save button pressed');
                  _showSaveDialog();
                }),
                SizedBox(width: 20),
                buildButton('Cancel', () {
                  print('Cancel button pressed');
                  _showCancelDialog();
                }, primary: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {int? maxLines, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          onTap: onTap,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget buildButton(String label, VoidCallback onPressed, {Color? primary}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: primary ?? Color(0xFFFA913B),
          onPrimary: primary == Colors.white ? Color(0xFFFA913B) : Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(105, 33),
        ),
        child: Text(label),
      ),
    );
  }

  Widget buildImageSelector(String label, XFile? selectedImage, VoidCallback pickImage, VoidCallback removeImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 30),
        if (selectedImage != null)
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey,
                  child: Image.file(
                    File(selectedImage.path),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.delete_forever_rounded),
                    onPressed: removeImage,
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(128, 255, 255, 255),
                    ),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 30),
        Center(
          child: Container(
            width: 100,
            height: 50,
            child: ElevatedButton(
              onPressed: pickImage,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Icon(Icons.cloud_upload_sharp, color: Color.fromARGB(255, 0, 170, 255)),
            ),
          ),
        ),
      ],
    );
  }
}
