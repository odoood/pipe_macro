%% PIPE Macro definition

% Internal macros, for use in the main one
-define('|FUN',PIPE_MACRO_INTERNAL_FUN_NAME).
-define('|Arg',PIPE_MACRO_INTERNAL_ARG_NAME).
-define(PARG,?'|Arg').

% The main macro
-define(PIPE(FExpr,PExpr),
fun
  ?'|FUN'(undef) ->
    ?'|FUN'({??FExpr, FExpr});
  ?'|FUN'({??FExpr, ?'|Arg'}) ->
    PExpr
end(undef)).
