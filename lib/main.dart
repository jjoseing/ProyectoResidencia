import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_resi/src/blocs/mypermisos_bloc.dart';

import 'package:app_resi/src/blocs/provider.dart';

import 'package:app_resi/src/pages/home_page.dart';
import 'package:app_resi/src/pages/login_page.dart';
import 'package:app_resi/src/pages/mypermisos_section.dart';
import 'package:app_resi/src/repository/permisos_repository.dart';

//import 'package:app_resi/src/pages/permiso_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          
          'login' : ( BuildContext context ) => LoginPage(),
          //'permisoApp': ( BuildContext context ) => PermisoPage(),
          'permisoApp': ( BuildContext context ) => BlocProvider(
                                  builder: (context) => MyPermisosBloc(permisosRepository: PermisosRepository(),codigo: '201710542')..add(LoadPermisos()),
                                  child: MyPermisosSection(codigo: '201710542',)),
          'home'  : ( BuildContext context ) => HomePage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
      
  }
}