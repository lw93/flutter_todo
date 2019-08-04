class ToDoResponse<T> {
  int code;
  String msg;
  T data;

  ToDoResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        msg = json['msg'],
        data = json['data'];
}

class LoginResponse {
  Planer user;
  PlanerSetting setting;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        setting = json['setting'];

  Map<String, dynamic> toJson() =>
      {
        'setting': setting,
        'user': user
      };
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
      : createdAt = json['createdAt'],
        emailVerified = json['emailVerified'],
        mobilePhoneVerified = json['mobilePhoneVerified'],
        nickname = json['nickname'],
        objectId = json['objectId'],
        updatedAt = json['updatedAt'],
        username = json['username'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'createdAt': createdAt,
        'email': email,
        'emailVerified': emailVerified,
        'mobilePhoneVerified': mobilePhoneVerified,
        'nickname': nickname,
        'objectId': objectId,
        'updatedAt': updatedAt,
        'username': username,
      };
}

class PlanerSetting {
  String createdAt;
  bool emailEveryDayEable;
  String objectId;
  String updatedAt;
  String userId;

  PlanerSetting.fromJson(Map<String, dynamic> json)
      : createdAt = json['createdAt'],
        objectId = json['objectId'],
        updatedAt = json['updatedAt'],
        userId = json['userId'],
        emailEveryDayEable = json['emailEveryDayEable'];

  Map<String, dynamic> toJson() =>
      {
        'createdAt': createdAt,
        'emailEveryDayEable': emailEveryDayEable,
        'objectId': objectId,
        'updatedAt': updatedAt,
        'userId': userId,
      };
}

class Todo<TAG> {
  bool completed;
  String content;
  String createdAt;
  String groupId;
  String objectId;
  double onFile;
  bool onFileAt;
  int priority;
  List<TAG> tags;
  String title;
  String uri;
  String userId;
  String updatedAt;

  Todo.fromJson(Map<String, dynamic> json)
      : completed = json['completed'],
        content = json['content'],
        createdAt = json['createdAt'],
        groupId = json['groupId'],
        objectId = json['objectId'],
        onFile = json['onFile'],
        onFileAt = json['onFileAt'],
        priority = json['priority'],
        tags = json['tags'],
        title = json['title'],
        uri = json['uri'],
        userId = json['userId'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() =>
      {
        'createdAt': createdAt,
        'content': content,
        'completed': completed,
        'groupId': groupId,
        'onFile': onFile,
        'onFileAt': onFileAt,
        'priority': priority,
        'tags': tags,
        'uri': uri,
        'tags': tags,
        'title': title,
        'objectId': objectId,
        'updatedAt': updatedAt,
        'userId': userId,
      };
}

class Group extends Todo {
  String name;
  String projectId;

  Group.fromJson(Map<String, dynamic> json)
      :name=json['name'],
        projectId=json['projectId'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['name'] = name;
    json['projectId'] = projectId;
    return json;
  }
}

class Project extends Todo {
  String name;
  String projectId;

  Project.fromJson(Map<String, dynamic> json)
      :name=json['name'],
        projectId=json['projectId'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['name'] = name;
    json['projectId'] = projectId;
    return json;
  }
}

//post
class LoginRequest {
  String username;
  String password;

  LoginRequest.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password
      };
}
//post
class RegisterRequest {
  String email;
  String nikename;
  String password;

  RegisterRequest.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        nikename = json['nikename'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'nikename': nikename,
        'password': password
      };
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
      : title = json['title'],
        userId = json['userId'],
        content = json['content'],
        groupId = json['groupId'],
        priority = json['priority'],
        completed = json['completed'],
        onFile = json['onFile'];

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'userId': userId,
        'content': content,
        'groupId': groupId,
        'priority': priority,
        'completed': completed,
        'onFile': onFile
      };
}

//put
class UpdateTodoRequest extends CreateTodoRequest {
  double completedAt;
  double onFileAt;

  UpdateTodoRequest.fromJson(Map<String, dynamic> json)
      : completedAt = json['completedAt'],
        onFileAt = json['onFileAt'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['completedAt'] = completedAt;
    json['completedAt'] = completedAt;
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
      : name = json['name'],
        userId = json['userId'],
        projectId = json['projectId'],
        priority = json['priority'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'userId': userId,
        'projectId': projectId,
        'priority': priority,
      };

}
//post
class UpdateGroupRequest {
  String name;
  String objectId;
  String projectId;
  int priority;

  UpdateGroupRequest.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        objectId = json['objectId'],
        projectId = json['projectId'],
        priority = json['priority'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'objectId': objectId,
        'projectId': projectId,
        'priority': priority,
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