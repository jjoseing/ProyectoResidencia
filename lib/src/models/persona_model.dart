import 'dart:convert';

PermisoModel permisoModelFromJson(String str) => PermisoModel.fromJson(json.decode(str));

String permisoModelToJson(PermisoModel data) => json.encode(data.toJson());

class PermisoModel {
    String clave;
    String nombre;
    String privilegio;

    PermisoModel({
        this.clave,
        this.nombre,
        this.privilegio,
    });

    factory PermisoModel.fromJson(Map<String, dynamic> json) => PermisoModel(
        clave: json["clave"],
        nombre: json["nombre"],
        privilegio: json["privilegio"],
    );

    Map<String, dynamic> toJson() => {
        "clave": clave,
        "nombre": nombre,
        "privilegio": privilegio,
    };
}
