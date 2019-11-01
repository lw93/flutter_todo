class TodoApi {
  static const String BASE_URL = 'https://waishuo.leanapp.cn/';
  static const String LOGIN = 'api/v1.0/users/login'; //POST
  static const String REGISTER = 'api/v1.0/users/register'; //POST
  static const String PLANNER = 'api/v1.0/users/<userId>'; //GET
  static const String CREATE_TODOS = 'api/v1.0/todos'; //POST
  static const String UPDATE_TODOS = 'api/v1.0/todos/<todoId>'; //PUT
  static const String DELETE_TODOS = 'api/v1.0/todos/<todoId>'; //DELETE
  static const String GET_TODOS = 'api/v1.0/todos/<todoId>'; //GET
  static const String CREATE_GROUP = 'api/v1.0/groups'; //POST
  static const String UPDATE_GROUP = 'api/v1.0/groups'; //PUT
  static const String GET_GROUP_PROJECTS = 'api/v1.0/groups/projects/<projectId>'; //GET
  static const String DELETE_GROUP = 'api/v1.0/groups/<objectId>'; //DELETE
  static const String CREATE_PROJECT = 'api/v1.0/project'; //POST
  static const String UPDATE_PROJECT = 'api/v1.0/project'; //PUT
  static const String DELETE_PROJECT = 'api/v1.0/project/<projectId>'; //DELETE
  static const String USER_SETTING = 'api/v1.0/users/setting'; //POST
  static const String GET_DEFAULT_PROJECTS = 'api/v1.0/projects/<projectId>'; //GET
  static const String GET_PROJECT_TODOS = 'api/v1.0/todos/projects/<projectId>/<objectId>'; //GET

}

class HttpStatus{
  static const int SUCCESS = 600;

}
