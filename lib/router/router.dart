import 'package:auto_route/annotations.dart';
import 'package:younmin/features/home/pages/home_page.dart';
import 'package:younmin/features/login/pages/login_page.dart';
import 'package:younmin/features/questions/pages/questions_page.dart';
import 'package:younmin/features/sign_up/pages/sign_up_page.dart';
import 'package:younmin/features/main/pages/main_page.dart';
import 'package:younmin/features/yearlyTodo/pages/yearly_todo_page.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(path: "/", page: Home, initial: true),
  AutoRoute(path: "/login", page: Login),
  AutoRoute(path: "/signUp", page: SignUp),
  AutoRoute(path: "/yearlyTodo", page: YearlyTodo),
  AutoRoute(path: "/questions", page: Questions),
  AutoRoute(path: "main/:id", page: MainPage),
])
class $YounminRouter {}
