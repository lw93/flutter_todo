class ToDoResponse {
  int code;
  String msg;
  Map<String, dynamic> data;

  ToDoResponse.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        msg = json["msg"],
        data = json["data"];

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data,
      };
}

class LoginResponse {
  Map<String, dynamic> user;
  Map<String, dynamic> setting;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : user = json["user"],
        setting = json["setting"];

  Map<String, dynamic> toJson() => {"setting": setting, "user": user};
}

//计划者即使用者
class Planer {
  String createdAt;
  String email;
  bool emailVerified;
  bool mobilePhoneVerified;
  String nickname;
  String objectId;
  String updatedAt;
  String username;

  Planer.fromJson(Map<String, dynamic> json)
      : createdAt = json["createdAt"],
        emailVerified = json["emailVerified"],
        mobilePhoneVerified = json["mobilePhoneVerified"],
        nickname = json["nickname"],
        objectId = json["objectId"],
        updatedAt = json["updatedAt"],
        username = json["username"],
        email = json["email"];

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "email": email,
        "emailVerified": emailVerified,
        "mobilePhoneVerified": mobilePhoneVerified,
        "nickname": nickname,
        "objectId": objectId,
        "updatedAt": updatedAt,
        "username": username,
      };
}

class PlanerSetting {
  String createdAt;
  bool emailEveryDayEnable;
  String objectId;
  String updatedAt;
  String userId;

  PlanerSetting.fromJson(Map<String, dynamic> json)
      : createdAt = json["createdAt"],
        objectId = json["objectId"],
        updatedAt = json["updatedAt"],
        userId = json["userId"],
        emailEveryDayEnable = json["emailEveryDayEnable"];

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "emailEveryDayEnable": emailEveryDayEnable,
        "objectId": objectId,
        "updatedAt": updatedAt,
        "userId": userId,
      };
}

class Todo {
  bool completed;
  String content;
  double createdAt;
  String groupId;
  String objectId;
  bool onFile;
  bool onFileAt;
  int priority;
  List tags;
  String title;
  String uri;
  String userId;
  double updatedAt;

  Todo.fromJson(Map<String, dynamic> json)
      : completed = json["completed"],
        content = json["content"],
        createdAt = json["createdAt"],
        groupId = json["groupId"],
        objectId = json["objectId"],
        onFile = json["onFile"],
        onFileAt = json["onFileAt"],
        priority = json["priority"],
        tags = json["tags"],
        title = json["title"],
        uri = json["uri"],
        userId = json["userId"],
        updatedAt = json["updatedAt"];

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "content": content,
        "completed": completed,
        "groupId": groupId,
        "onFile": onFile,
        "onFileAt": onFileAt,
        "priority": priority,
        "tags": tags,
        "uri": uri,
        "tags": tags,
        "title": title,
        "objectId": objectId,
        "updatedAt": updatedAt,
        "userId": userId,
      };
}

class Todos {
  List<Todo> results;
  List<Todo> resultsComplete;
  List<Todo> resultsOnFile;

  Todos({this.results, this.resultsComplete, this.resultsOnFile});

  factory Todos.fromJson(Map<String, dynamic> json) {
    if (null == json) return Todos();
    List resultsParm = json["results"];
    List resultsCompleteParm = json["resultsComplete"];
    List resultsOnFileParm = json["resultsOnFile"];
    return Todos(
        results: resultsParm.map((f) => Todo.fromJson(f)).toList(),
        resultsComplete:
            resultsCompleteParm.map((f) => Todo.fromJson(f)).toList(),
        resultsOnFile: resultsOnFileParm.map((f) => Todo.fromJson(f)).toList());
  }

  Map<String, dynamic> toJson() => {
        "results": results,
        "resultsComplete": resultsComplete,
        "resultsOnFile": resultsOnFile,
      };
}

class Group extends Todo {
  String name;
  String projectId;

  Group.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        projectId = json["projectId"],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json["name"] = name;
    json["projectId"] = projectId;
    return json;
  }
}

class Project {
  String name;
  String projectId;
  bool hasCompleteList;
  bool hasOnFileList;
  Todos todos;
  String createdAt;
  String updatedAt;
  String objectId;
  int priority;
  String userId;

  Project.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        projectId = json["projectId"],
        todos = Todos.fromJson(json["todos"]),
        hasCompleteList = json["hasCompleteList"],
        hasOnFileList = json["hasOnFileList"],
        createdAt = json["createdAt"],
        updatedAt = json["updatedAt"],
        objectId = json["objectId"],
        priority = json["priority"],
        userId = json["userId"];

  @override
  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();
    json["name"] = name;
    json["projectId"] = projectId;
    json["todos"] = todos.toJson();
    json["hasCompleteList"] = hasCompleteList;
    json["hasOnFileList"] = hasOnFileList;
    json["createdAt"] = createdAt;
    json["updatedAt"] = updatedAt;
    json["objectId"] = objectId;
    json["priority"] = priority;
    json["userId"] = userId;
    return json;
  }
}

//post
class LoginRequest {
  String username;
  String password;

  LoginRequest.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"];

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}

//post
class RegisterRequest {
  String email;
  String nikename;
  String password;

  RegisterRequest.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        nikename = json["nikename"],
        password = json["password"];

  Map<String, dynamic> toJson() =>
      {"email": email, "nikename": nikename, "password": password};
}

//post
class CreateTodoRequest {
  String title;
  String userId;
  String content;
  String groupId;
  int priority;
  bool completed;
  bool onFile;

  CreateTodoRequest.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        userId = json["userId"],
        content = json["content"],
        groupId = json["groupId"],
        priority = json["priority"],
        completed = json["completed"],
        onFile = json["onFile"];

  Map<String, dynamic> toJson() => {
        "title": title,
        "userId": userId,
        "content": content,
        "groupId": groupId,
        "priority": priority,
        "completed": completed,
        "onFile": onFile
      };
}

//put
class UpdateTodoRequest extends CreateTodoRequest {
  double completedAt;
  double onFileAt;

  UpdateTodoRequest.fromJson(Map<String, dynamic> json)
      : completedAt = json["completedAt"],
        onFileAt = json["onFileAt"],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json["completedAt"] = completedAt;
    json["completedAt"] = completedAt;
    return json;
  }
}

//post
class CreateGroupRequest {
  String name;
  String userId;
  String projectId;
  int priority;

  CreateGroupRequest.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        userId = json["userId"],
        projectId = json["projectId"],
        priority = json["priority"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "userId": userId,
        "projectId": projectId,
        "priority": priority,
      };
}

//post
class UpdateGroupRequest {
  String name;
  String objectId;
  String projectId;
  int priority;

  UpdateGroupRequest.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        objectId = json["objectId"],
        projectId = json["projectId"],
        priority = json["priority"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "objectId": objectId,
        "projectId": projectId,
        "priority": priority,
      };
}

//post
class CreateProjectRequest {
  String name;
  String userId;
  int priority;
}

//post
class UpdateProjectRequest {
  String name;
  String objectId;
  int priority;
}
