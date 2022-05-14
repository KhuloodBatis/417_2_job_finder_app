class Message
{
  late String message;
  late String idFrom;
  late String idTo;
  late DateTime date;

  Message({required this.message , required this.idFrom , required this.idTo , required this.date});

  Message.fromJson(Map<String , dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        message=map['message'];
        idFrom=map['idFrom'];
        idTo=map['idTo'];
        date=map['date'];
      }
  }
  toJson()
  {
    return {
      'message':message,
      'idFrom':idFrom,
      'idTo':idTo,
      'date' : date,
    };
  }

}