-module(macros).
-include_lib("eunit/include/eunit.hrl").

-include("../src/pipe_macro.hrl").

pipe_test() ->

  %% Pass a term to a func
  1 = ?PIPE([1], hd(?PARG)),
  [] = ?PIPE([1], tl(?PARG)),
  5 = ?PIPE("five!", length(?PARG)),

  %% Pass func output to a func
  [9,0,0,0,0,0,0] = ?PIPE(
       lists:duplicate(3, 0),
       lists:append([[9], ?PARG, ?PARG])), % use PARG anywhere, any # of times

  %% Use bound vars in pipeline
  Me = self(),
  [$I,$\ ,$a,$m,$:|_] = ?PIPE(pid_to_list(Me), lists:append(["I am:", ?PARG])),

  %% No func calls, just compose something
  #{one := 1, 1 := one} = ?PIPE(one, #{?PARG => 1, 1 => ?PARG}),

  ok.
