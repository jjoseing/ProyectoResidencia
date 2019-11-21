import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app_resi/src/blocs/permisos_event.dart';
import 'package:app_resi/src/blocs/permisos_state.dart';
import 'package:app_resi/src/repository/permisos_repository.dart';

export 'permisos_event.dart';
export 'permisos_state.dart';

class MyPermisosBloc extends Bloc<PermisosEvent, PermisosState> {
  final PermisosRepository _permisosRepository;
  final String _codigo;
  StreamSubscription _permisosSubscription;

  MyPermisosBloc({ @required PermisosRepository permisosRepository, @required String codigo })
      : assert(permisosRepository != null),
      _permisosRepository = permisosRepository,
      _codigo = codigo;

  @override
  PermisosState get initialState => PermisosLoading();

  @override
  Stream<PermisosState> mapEventToState( PermisosEvent event ) async* {
    if(event is LoadPermisos) {
      yield* _mapLoadPermisosToState();
    } else if(event is AddPermiso) {
      yield* _mapAddPermisoToState(event);
    } else if(event is PermisosUpdated) {
      yield* _mapPermisosUpdatedToState(event);
    }
  }

  Stream<PermisosState> _mapLoadPermisosToState() async* {
    _permisosSubscription?.cancel();
    _permisosSubscription = _permisosRepository.getMyPermisos(_codigo).listen(
      (permisos) => add(PermisosUpdated(permisos)),
    );
  }

  Stream<PermisosState> _mapAddPermisoToState(AddPermiso event) async* {
    _permisosRepository.addNewPermiso(event.permiso);
  }

  Stream<PermisosState> _mapPermisosUpdatedToState(PermisosUpdated event) async* {
    yield PermisosLoaded(event.permisos);
  }

  @override
  Future<void> close() {
    _permisosSubscription?.cancel();
    return super.close();
  }
}
