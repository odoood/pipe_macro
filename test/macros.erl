%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Copyright 2026 Orion De Shay <odoood@member.fsf.org>
%%%
%%% This file is part of Pipe Macro.
%%%
%%% Pipe Macro is free software: you can redistribute it and/or modify it
%%% under the terms of the GNU General Public License as published by the
%%% Free Software Foundation, version 3 of the License, and only
%%% version 3 of the License.
%%%
%%% Pipe Macro is distributed in the hope that it will be useful, but
%%% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
%%% or FITNESS FOR A PARTICULAR PURPOSE.
%%% See the GNU General Public License for more details.
%%%
%%% You should have received a copy of the GNU General Public License along
%%% with Pipe Macro. If not, see <https://www.gnu.org/licenses/>.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-module(macros).
-include_lib("eunit/include/eunit.hrl").

-include("../include/pipe_macro.hrl").

%% Copied from the Erlang docs programming examples
ints_from(N) ->
  fun() ->
    [N|ints_from(N+1)]
  end.

pipe_doc_test() ->
  [1, 2, 3] = ?PIPE([1, [2], 3], lists:flatten(?PARG)),

  [2, 4, 6] = ?PIPE([1, [2], 3],
                    lists:flatten(?PARG),
                    lists:map(fun(X) -> X * 2 end, ?PARG)),

  %% This will cause a compiler warning due to no `?PARG' in the 2nd expression
  [8, 10, 12] = ?PIPE([1, [2], 3], % this goes unused and triggers a warning
                      lists:flatten([4,[5],6]),
                      lists:map(fun(X) -> X * 2 end, ?PARG)), % uses flatten result

  %% Use bound vars in pipeline
  Me = pid_to_list(self()),
  [$I,$\ ,$a,$m,$:|Me] = ?PIPE(Me, lists:append(["I am:", ?PARG])),

  %% Create a nested anonymous function
  Upcase_word = ?PIPE(fun(X) when $a =< X,  X =< $z -> X + $A - $a; (X) -> X end,
                      fun(X) -> lists:map(?PARG, X) end),

  "ERLANG" = Upcase_word("Erlang"),

  ["I","LIKE","ERLANG"] = lists:map(Upcase_word, ["I","like","Erlang"]),

  XX = ints_from(1),

  First = hd(XX()),
  Tail1 = tl(XX()),

  Second = hd(Tail1()),
  Tail2 = tl(Tail1()),

  Third = hd(Tail2()),
  Tail3 = tl(Tail2()),

  Fourth = hd(Tail3()),
  Tail4 = tl(Tail3()),

  Fifth = hd(Tail4()),

  [1, 2, 3, 4, 5] = [First, Second, Third, Fourth, Fifth],

  YY = ints_from(1),

  %% Complicated, and may cause blindness, but works the same
  [1, 2, 3, 4, 5] =
    ?PIPE([tl(YY()), hd(YY())],
          [tl((hd(?PARG))()), hd((hd(?PARG))()) | tl(?PARG)],
          [tl((hd(?PARG))()), hd((hd(?PARG))()) | tl(?PARG)],
          [tl((hd(?PARG))()), hd((hd(?PARG))()) | tl(?PARG)],
          [tl((hd(?PARG))()), hd((hd(?PARG))()) | tl(?PARG)],
          lists:reverse(tl(?PARG))),
  ok.

pipe_test() ->

  %% Pass a term to a func
  1 = ?PIPE([1], hd(?PARG)),

  1 = ?PIPE([[1]],
            hd(?PARG),
            hd(?PARG)),

  [] = ?PIPE([1], tl(?PARG)),

  5 = ?PIPE("five!", length(?PARG)),

  $! = ?PIPE("five!",
             tl(?PARG),
             tl(?PARG),
             tl(?PARG),
             tl(?PARG),
             hd(?PARG)),

  %% Pass func output to a func
  [9,0,0,0,0,0,0] = ?PIPE(
       lists:duplicate(3, 0),
       lists:append([[9], ?PARG, ?PARG])), % use PARG anywhere, any # of times

  %% Use bound vars in pipeline
  Me = pid_to_list(self()),
  [$I,$\ ,$a,$m,$:|Me] = ?PIPE(Me, lists:append(["I am:", ?PARG])),

  %% No func calls, just compose something
  #{one := 1, 1 := one} = ?PIPE(one, #{?PARG => 1, 1 => ?PARG}),

  {0, {{1}}} = ?PIPE(1,
                     {?PARG},
                     {?PARG},
                     {0, ?PARG}),

  ok.
