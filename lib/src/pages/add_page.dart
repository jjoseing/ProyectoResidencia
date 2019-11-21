import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:app_resi/src/utils/date.dart';


typedef OnSaveCallBack = Function(String comentario, DateTime fechaentrada, DateTime fechasalida, String motivo );

class AddPage extends StatefulWidget {
  final OnSaveCallBack onSave;    
  // final String uid;
  final _motivosList = ['Paseo','Viaje','Compras','Personales'];
  // final Permiso _permiso;

  // AddPage({Key key, @required this.onSave})
  AddPage({Key key, this.onSave})
    // : _permiso = permiso, super(key: key);
    : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fechsalida = new TextEditingController();
  TextEditingController _fechentrada = new TextEditingController();
  String comentario,  motivo;
  DateTime fechaentrada, fechasalida;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Solicitud'),
        actions: <Widget>[
          FlatButton(
            child: Text('ENVIAR',
              style: TextStyle(color: Colors.white,),
            ),            
            onPressed: _onSubmit,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // TextFormField(
                // decoration: InputDecoration(
              //     icon: Icon(Icons.location_on),
              //     hintText: 'codigo',
              //   ),
              //   validator: (val) {
              //     return val.trim().isEmpty ? 'Este campo es requerido.' : null;
              //   },
              //   onSaved: (value) {
              //     codigo = value;
              //   },
              // ),
              DropdownButtonFormField(
                value: motivo,
                hint: Text('Motivo'),
                decoration: InputDecoration(
                  icon: Icon(Icons.help_outline),
                ),
                items: widget._motivosList.map(
                  (m) => DropdownMenuItem( child: Text(m), value: m )               
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    motivo = value;
                  });
                },
                validator: (val) {
                  return val==null ? 'Este campo es requerido.' : null;
                },
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.date_range)
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _fechsalida,
                      decoration: InputDecoration(
                        hintText: 'Fecha de salida',
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _mostrarDateTimeSelector(
                          (datetime) { 
                            setState(() {
                              fechasalida = datetime;
                              _fechsalida.text = Format.toMonthDayDate(datetime);                              
                            });
                          }
                        );
                      },
                      validator: (val) {
                        return val.trim().isEmpty ? 'Este campo es requerido.' : null;
                      },
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Flexible(
                    child: TextFormField(
                      controller: _fechentrada,
                      decoration: InputDecoration(
                        hintText: 'Fecha de retorno',  
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _mostrarDateTimeSelector(
                          (datetime) {
                            setState(() {
                               fechaentrada = datetime;
                              _fechentrada.text = Format.toMonthDayDate(datetime);                             
                            });
                          }
                        );
                      },
                      validator: (val) {
                        return val.trim().isEmpty ? 'Este campo es requerido.' : null;
                      },
                    )
                  ),
                ],
              ),
              TextFormField(                
                maxLines: 5,
                decoration: InputDecoration(
                  icon: Icon(Icons.message),
                  hintText: 'Comentarios',
                ),
                onSaved: (value) {
                  comentario = value;
                },
              ),
            ],
          ),          
        ),
      ),
    );
  }

  void _mostrarDateTimeSelector(Function(DateTime) onConfirm) {
    DatePicker.showDateTimePicker(context,
      minTime: DateTime(2019, 11, 1),
      maxTime: DateTime(2019, 12, 31),
      locale: LocaleType.es,
      onConfirm: onConfirm,       
    );
  }

  void _onSubmit() {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //TODO CONVERTIR A FECHA
      widget.onSave(comentario, fechaentrada, fechasalida, motivo );
      Navigator.pop(context);
    }
  }
}