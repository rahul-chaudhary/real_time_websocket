import 'model/data.dart';

abstract class DataState {

}

class DataInitialState extends DataState {

}

class DataPresentState extends DataState{
  RealtimeDataModel data;
  DataPresentState({required this.data});
}


class DataErrorState extends DataState {

}