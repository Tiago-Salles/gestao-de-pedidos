class ClientModel{

  String? clientName;
  String? data;
  String? request;

  ClientModel({this.clientName, this.data, this.request});

  ClientModel.fromJson(Map json){
    clientName = json["clientName"];
    data = json["data"];
    request = json["request"];
  }
}