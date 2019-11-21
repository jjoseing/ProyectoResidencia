import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_resi/src/models/permiso_model.dart';

class PermisosRepository {
  final permisoCollection = 
   Firestore.instance.collection('perm_permiso');

  Future<void> addNewPermiso(PermisoModel permiso) {
    return permisoCollection.add(permiso.toJson());
  }

  // Delete ? 

  Stream<List<PermisoModel>> getMyPermisos(String codigo) {
   
    return permisoCollection.where('codigo', isEqualTo: codigo)
    .snapshots().map((snapshot) {
      return snapshot.documents
        // .map((doc) => PermisoModel.fromJson(doc) )
        .map((doc) => PermisoModel.fromJson(doc))
        .toList();
    });
  }

  Stream<List<PermisoModel>> getAllPermisos() {
    return permisoCollection.where('aprobacion',isEqualTo: true)
    .snapshots().map((snapshot) {
      return snapshot.documents
      .map((doc) => PermisoModel.fromJson(doc))
      .toList();
    });
  }

  Stream<List<PermisoModel>> getAllSolicitudes() {
    return permisoCollection.where('agruaproba',isEqualTo: false)
    .snapshots().map((snapshot) {
      return snapshot.documents
      .map((doc) => PermisoModel.fromJson(doc))
      .toList();
    });
  }
}