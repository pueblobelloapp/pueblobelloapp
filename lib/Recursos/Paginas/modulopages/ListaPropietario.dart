import 'package:app_turismo/Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaPropietario extends StatelessWidget {
  const ListaPropietario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _propietarioStream =
        FirebaseFirestore.instance.collection('propietario').snapshots();

    return Container(
        color: Colors.grey.shade100,
        child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: _propietarioStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return listaPropietario(data);
                          })
                          .toList()
                          .cast());
                })));
  }

  Widget listaPropietario(Map<String, dynamic> data) {
    return ListTile(
      leading: data['foto'] == ""
          ? Image.asset('assets/Icons/usuarioPerfil.png')
          : Image.network(data['foto']),
      title: Text(data['nombre']),
      subtitle: Text(""),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: () {
        final editController = Get.find<GextPropietarioController>();
        editController.updatePropietario(data, "Actualizar");
        editController.updateTapItem(1);
      },
    );
  }
}
