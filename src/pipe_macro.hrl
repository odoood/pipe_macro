%% PIPE Macro definition

-define('|FUN',PIPE_MACRO_INTERNAL_FUN_NAME).
-define(PARG, PIPE_MACRO_INTERNAL_ARG_NAME).

% PIPE/2
-define(PIPE(Expr1,Expr2),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> Expr2
end({0, undef})).

% PIPE/3
-define(PIPE(Expr1,Expr2,Expr3),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> Expr3
end({0, undef})).

% PIPE/4
-define(PIPE(Expr1,Expr2,Expr3,Expr4),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> ?'|FUN'({3, Expr3});
  ?'|FUN'({3, ?PARG}) -> Expr4
end({0, undef})).

% PIPE/5
-define(PIPE(Expr1,Expr2,Expr3,Expr4,Expr5),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> ?'|FUN'({3, Expr3});
  ?'|FUN'({3, ?PARG}) -> ?'|FUN'({4, Expr4});
  ?'|FUN'({4, ?PARG}) -> Expr5
end({0, undef})).

% PIPE/6
-define(PIPE(Expr1,Expr2,Expr3,Expr4,Expr5,Expr6),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> ?'|FUN'({3, Expr3});
  ?'|FUN'({3, ?PARG}) -> ?'|FUN'({4, Expr4});
  ?'|FUN'({4, ?PARG}) -> ?'|FUN'({5, Expr5});
  ?'|FUN'({5, ?PARG}) -> Expr6
end({0, undef})).

% PIPE/7
-define(PIPE(Expr1,Expr2,Expr3,Expr4,Expr5,Expr6,Expr7),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> ?'|FUN'({3, Expr3});
  ?'|FUN'({3, ?PARG}) -> ?'|FUN'({4, Expr4});
  ?'|FUN'({4, ?PARG}) -> ?'|FUN'({5, Expr5});
  ?'|FUN'({5, ?PARG}) -> ?'|FUN'({6, Expr6});
  ?'|FUN'({6, ?PARG}) -> Expr7
end({0, undef})).

% PIPE/8
-define(PIPE(Expr1,Expr2,Expr3,Expr4,Expr5,Expr6,Expr7,Expr8),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> ?'|FUN'({3, Expr3});
  ?'|FUN'({3, ?PARG}) -> ?'|FUN'({4, Expr4});
  ?'|FUN'({4, ?PARG}) -> ?'|FUN'({5, Expr5});
  ?'|FUN'({5, ?PARG}) -> ?'|FUN'({6, Expr6});
  ?'|FUN'({6, ?PARG}) -> ?'|FUN'({7, Expr7});
  ?'|FUN'({7, ?PARG}) -> Expr8
end({0, undef})).

% PIPE/9
-define(PIPE(Expr1,Expr2,Expr3,Expr4,Expr5,Expr6,Expr7,Expr8,Expr9),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> ?'|FUN'({3, Expr3});
  ?'|FUN'({3, ?PARG}) -> ?'|FUN'({4, Expr4});
  ?'|FUN'({4, ?PARG}) -> ?'|FUN'({5, Expr5});
  ?'|FUN'({5, ?PARG}) -> ?'|FUN'({6, Expr6});
  ?'|FUN'({6, ?PARG}) -> ?'|FUN'({7, Expr7});
  ?'|FUN'({7, ?PARG}) -> ?'|FUN'({8, Expr8});
  ?'|FUN'({8, ?PARG}) -> Expr9
end({0, undef})).

% PIPE/10
-define(PIPE(Expr1,Expr2,Expr3,Expr4,Expr5,Expr6,Expr7,Expr8,Expr9,Expr10),
fun
  ?'|FUN'({0, undef}) -> ?'|FUN'({1, Expr1});
  ?'|FUN'({1, ?PARG}) -> ?'|FUN'({2, Expr2});
  ?'|FUN'({2, ?PARG}) -> ?'|FUN'({3, Expr3});
  ?'|FUN'({3, ?PARG}) -> ?'|FUN'({4, Expr4});
  ?'|FUN'({4, ?PARG}) -> ?'|FUN'({5, Expr5});
  ?'|FUN'({5, ?PARG}) -> ?'|FUN'({6, Expr6});
  ?'|FUN'({6, ?PARG}) -> ?'|FUN'({7, Expr7});
  ?'|FUN'({7, ?PARG}) -> ?'|FUN'({8, Expr8});
  ?'|FUN'({8, ?PARG}) -> ?'|FUN'({9, Expr9});
  ?'|FUN'({9, ?PARG}) -> Expr10
end({0, undef})).
