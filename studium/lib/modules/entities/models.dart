import 'dart:convert';

class ActivityCollection {
  List<Day> days;

  ActivityCollection({
    required this.days,
  });

  factory ActivityCollection.fromRawJson(String str) => ActivityCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityCollection.fromJson(Map<String, dynamic> json) => ActivityCollection(
    days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "days": List<dynamic>.from(days.map((x) => x.toJson())),
  };
}

class Day {
  DateTime date;
  int week;
  int weekDay;
  List<Activity> activities;

  Day({
    required this.date,
    required this.week,
    required this.weekDay,
    required this.activities,
  });

  factory Day.fromRawJson(String str) => Day.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    date: DateTime.parse(json["date"]),
    week: json["week"],
    weekDay: json["weekDay"],
    activities: List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "week": week,
    "weekDay": weekDay,
    "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
  };
}

class Activity {
  String id;
  String name;
  String description;
  List<Class> classes;
  String type;
  int week;
  int weekDay;
  String startTime;
  String endTime;
  List<Staff> staff;
  List<Room> rooms;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.classes,
    required this.type,
    required this.week,
    required this.weekDay,
    required this.startTime,
    required this.endTime,
    required this.staff,
    required this.rooms,
  });

  factory Activity.fromRawJson(String str) => Activity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    classes: List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
    type: json["type"],
    week: json["week"],
    weekDay: json["weekDay"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    staff: List<Staff>.from(json["staff"].map((x) => Staff.fromJson(x))),
    rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
    "type": type,
    "week": week,
    "weekDay": weekDay,
    "startTime": startTime,
    "endTime": endTime,
    "staff": List<dynamic>.from(staff.map((x) => x.toJson())),
    "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
  };
}

class Class {
  String id;
  String name;
  String description;
  Department? department;

  Class({
    required this.id,
    required this.name,
    required this.description,
    this.department,
  });

  factory Class.fromRawJson(String str) => Class.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    department: json["department"] == null ? null : Department.fromJson(json["department"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "department": department?.toJson(),
  };
}

class Department {
  String id;
  String name;
  String description;
  String telefon;
  String fax;
  String street;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.telefon,
    required this.fax,
    required this.street,
  });

  factory Department.fromRawJson(String str) => Department.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    telefon: json["telefon"],
    fax: json["fax"],
    street: json["street"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "telefon": telefon,
    "fax": fax,
    "street": street,
  };
}


class Room {
  String id;
  String name;
  String description;
  Department department;
  int capacity;
  Address address;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.department,
    required this.capacity,
    required this.address,
  });

  factory Room.fromRawJson(String str) => Room.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    department: Department.fromJson(json["department"]),
    capacity: json["capacity"],
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "department": department.toJson(),
    "capacity": capacity,
    "address": address.toJson(),
  };
}

class Staff {
  String id;
  String name;
  String fullName;
  Department department;
  String room;
  String email;
  String phone;

  Staff({
    required this.id,
    required this.name,
    required this.fullName,
    required this.department,
    required this.room,
    required this.email,
    required this.phone,
  });

  factory Staff.fromRawJson(String str) => Staff.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    id: json["id"],
    name: json["name"],
    fullName: json["fullName"],
    department: Department.fromJson(json["department"]),
    room: json["room"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "fullName": fullName,
    "department": department.toJson(),
    "room": room,
    "email": email,
    "phone": phone,
  };
}

class Address {
  String id;
  String name;
  String description;

  Address({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}

