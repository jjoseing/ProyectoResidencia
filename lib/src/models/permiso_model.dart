import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PermisoModel permisoModelFromJson(String str) => PermisoModel.fromJson(json.decode(str));

String permisoModelToJson(PermisoModel data) => json.encode(data.toJson());

class PermisoModel {
    String codigo;
    String comentarios;
    DateTime fechaentrada;
    DateTime fechasalida;
    String motivo;

    PermisoModel({
        this.codigo,
        this.comentarios,
        this.fechaentrada,
        this.fechasalida,
        this.motivo,
    });

    factory PermisoModel.fromJson(DocumentSnapshot json) => PermisoModel(
        codigo: json.data["codigo"],
        comentarios: json.data["comentarios"],
        fechaentrada: (json.data["fechaentrada"] as Timestamp).toDate(),
        fechasalida: (json.data["fechasalida"] as Timestamp).toDate(),
        motivo: json.data["motivo"],
    );

    


    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "comentarios": comentarios,
        "fechaentrada": Timestamp.fromDate(fechaentrada),
        "fechasalida": Timestamp.fromDate(fechasalida),
        "motivo": motivo,
    };

}
