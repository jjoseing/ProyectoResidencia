import 'package:flutter/material.dart';
import 'package:app_resi/src/models/permiso_model.dart';
import 'package:app_resi/src/utils/date.dart';

class DetailPage extends StatelessWidget {
  final _estado = const ['Autorización','Control de Salida','Control de Entrada'];
  final PermisoModel _permiso;

  const DetailPage({Key key, @required PermisoModel permiso}) : _permiso = permiso, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle'),
      ),
      body: ListView(
        
        children: _crearDetails(),
      ),
    );
  }

  List<Widget> _crearDetails() {
    final List<Widget> props = 
    [
      
      ListTile(
        title: Text('Motivo'),
        subtitle: Text(_permiso.motivo),
      ),
      ListTile(
        title: Text('Fecha de salida'),
        subtitle: Text(_permiso.fechasalida.toString()),
      ),
      ListTile(
        title: Text('Fecha de entrada'),
        subtitle: Text(Format.toMonthDayDate(_permiso.fechaentrada)),
      ),
      ListTile(
        title: Text('Comentarios'),
        subtitle: Text(_permiso.comentarios.isEmpty?'(Vacío)':_permiso.comentarios),
      ),       
    ];

    return props;
  }
}