import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropietariosPage extends StatefulWidget {
  const PropietariosPage({super.key});

  @override
  State<PropietariosPage> createState() => _PropietariosPageState();
}

class _PropietariosPageState extends State<PropietariosPage> {
  final Stream<QuerySnapshot> _propietarioStream =
      FirebaseFirestore.instance.collection('propietario').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Propietarios")),
      body: StreamBuilder(
        stream: _propietarioStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Lo sentimos se ha producido un error.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Cargando datos.'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text("Sin datos para mostrar",
                    style: TextStyle(fontWeight: FontWeight.bold)));
          }

          return ListView(
              children: List.generate(snapshot.data!.docs.length, (index) {
            if (snapshot.data!.docs[index]['rool'] == 'Administrador') {
              return SizedBox();
            }

            bool estado = false;
            try {
              estado = snapshot.data!.docs[index]['estado'];
            } catch (e) {}

            return ListTile(
              title: Text(snapshot.data!.docs[index]['nombre']),
              subtitle: Text(snapshot.data!.docs[index]['correo']),
              trailing: Switch(
                  value: estado,
                  onChanged: (value) async {
                    print(snapshot.data!.docs[index].id);
                    await FirebaseFirestore.instance
                      .collection('propietario')
                      .doc(snapshot.data!.docs[index].id)
                      .update({'estado' : value}).then((value) {
                        print("Actualizado");
                        Get.snackbar("Actualizado", "Actualizado", 
                        snackPosition: SnackPosition.BOTTOM, 
                        backgroundColor: Colors.green);
                      }).onError((error, stackTrace) {
                        Get.snackbar("Actualizado", "Error al actualizar");
                      });
                  }),
              onTap: () {
                print(snapshot.data!.docs[index].id);
              },
            );
          }));
        },
      ),
    );
  }
}
