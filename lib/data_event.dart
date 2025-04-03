/*
NOTE: Ideally there should be an error state too, but I am not handling the error here since this is just an implementation guide, that is why I have not included the error state.
*/

abstract class DataEvent {

}

class DataConnectEvent extends DataEvent {

}

class UpdateDataEvent extends DataEvent {
  Map data;

  UpdateDataEvent({required this.data});
}