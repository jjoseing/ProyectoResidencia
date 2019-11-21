import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:residenciaproyect/src/blocs/tab_bloc/tab_bloc.dart';
import 'package:app_resi/src/models/permiso_model.dart';
import 'package:app_resi/src/pages/add_page.dart';
//import 'package:app_resi/src/pages/perfil_section.dart';
import 'package:app_resi/src/pages/mypermisos_section.dart';

class ResidenteHomePage extends StatefulWidget {

  // final String _userUid;
  final List<Widget> _sections;

  ResidenteHomePage({Key key, @required userUid}):
    // : _userUid = userUid,
    _sections = [
      MyPermisosSection(codigo: '201710542',),
      Text('Usuario')
      //PerfilSection(userUid: userUid,)
    ],
    super(key: key);

  @override
  _ResidenteHomePageState createState() => _ResidenteHomePageState();
}

class _ResidenteHomePageState extends State<ResidenteHomePage> {
  int _tabIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: widget._sections[_tabIndex],
          bottomNavigationBar: _crearBottomNavBar(context),
        );
  }

  Widget _crearBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _tabIndex,
      onTap: (index) {
        setState(() {
          _tabIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_open),
          title: Text('Mis permisos')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text('Mi usuario')
        ),
      ],
    );
  }
}