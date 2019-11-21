import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:residenciaproyect/blocs/filtered_permisos/filtered_permisos_bloc.dart';
import 'package:app_resi/src/blocs/mypermisos_bloc.dart';
import 'package:app_resi/src/models/permiso_model.dart';
import 'package:app_resi/src/pages/add_page.dart';
import 'package:app_resi/src/pages/detail_page.dart';
import 'package:app_resi/src/utils/date.dart';


class ListaPermisos extends StatelessWidget {
  final String _codigo;

  const ListaPermisos({ @required codigo,Key key}) : _codigo = codigo, super(key: key);  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis permisos'),
      ),
      floatingActionButton: _crearFab(context),
      body: BlocBuilder<MyPermisosBloc, PermisosState>(
        builder: (context, state) {
          if(state is PermisosLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is PermisosLoaded) {
            final permisos = state.permisos;
            return ListView.builder(
              itemCount: permisos.length,
              // separatorBuilder: (context, index) => Divider(height: 1,),
              itemBuilder: (context, index) {
                final per = permisos[index];
                  return _crearPermisoItem( per, onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(permiso: per,)
                      ) 
                    );
                  });
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );

    
  }  

  Widget _crearPermisoItem(PermisoModel per, { @required Function onTap }) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Format.toMonthDayDate(per.fechasalida)),
            Text(Format.toMonthDayDate(per.fechaentrada)),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Text('${per.motivo},${per.codigo}'),
            //Text(Format.toMonthDayDate(per.createdAt),
            // 
            //style: TextStyle(fontSize: 14.00),),
          ]
        ),
        subtitle: Text('Aprobado'),
        onTap: onTap,
      ),
    );
  }

  Widget _crearSolicitudItem(PermisoModel sol,  { @required Function onTap }) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Format.toMonthDayDate(sol.fechasalida)),
            Text(Format.toMonthDayDate(sol.fechaentrada)),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Text(' ${sol.motivo}'),
            //Text(Format.formatMonthDayDate(sol.createdAt),
            //style: TextStyle(fontSize: 14.00),),
          ]
        ),
        subtitle: Text('Pendiente'),
        onTap: onTap,
      ),
    );
  }

  Widget _crearFab(BuildContext context) {
    return FloatingActionButton(           
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<AddPage>(
            builder: (contextPage) {
              return AddPage(
                  onSave: (comentarios, fechaentrada, fechasalida, motivo ) {
                    BlocProvider.of<MyPermisosBloc>(context).add(
                      AddPermiso(
                        PermisoModel(
                          codigo: _codigo,
                          comentarios: comentarios,
                          fechaentrada: fechaentrada,
                          fechasalida: fechasalida,
                          motivo: motivo, 
                        )
                      ),
                    );
                  }
                );
            }
          )
        );
      },
    );
  }
}