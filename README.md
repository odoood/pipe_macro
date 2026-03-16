Pipe Macro
==========

This package provides an Erlang macro to mimic the Elixir pipe operator, but
with some additional capabilities compared to its Elixir counterpart.

Usage
-----

The main file is the header `include/pipe_macro.hrl` which defines the macro;
include it in any module where it will be used with the usual directive:

```erlang
-include_lib("pipe_macro/include/pipe_macro.hrl").
```

The macros defined here are `?PIPE` and `?PARG`--they work together to achieve
pipeline functionality similar to `|>` in Elixir.
The main difference is that while `|>` implicitly passes results, `?PARG` must
explicitly be used wherever a result is to be passed.
The basic form is:

```erlang
?PIPE(Expr1, Expr2, ..., ExprN)
```

where each `Expr` parameter is any valid Erlang expression. Any `Expr` _after_
the first can include any number of `?PARG`. Any `?PARG` used in the first
expression is an error.

> 💡 `?PIPE` overloads have been defined up to an arity of 10. If you want to
> use more than 10 expressions, simply add overloads in the header file
> following the established pattern.


All `?PARG` are replaced by the result of the previous expression.
For example:

```erlang
[1, 2, 3] = ?PIPE([1, [2], 3], lists:flatten(?PARG))
```

See [Examples](#examples) for more.

Examples
--------

### Passing results

The result of an expression must be explicitly passed with `?PARG` to use it in
the expression that follows:

```erlang
%% Same as lists:flatten([1, [2], 3])
[1, 2, 3] = ?PIPE([1, [2], 3], lists:flatten(?PARG)),

%% Same as lists:map(fun(X) -> X * 2 end, lists:flatten([1, [2], 3]))
[2, 4, 6] = ?PIPE([1, [2], 3],
                  lists:flatten(?PARG),
                  lists:map(fun(X) -> X * 2 end, ?PARG)),
```

If `?PARG` is _not_ used, the previous expression's result is ignored, and the
compiler will give a warning about an unused variable:

```erlang
%% This will cause a compiler warning due to no `?PARG' in the 2nd expression
[8, 10, 12] = ?PIPE([1, [2], 3], % this goes unused and triggers a warning
                    lists:flatten([4,[5],6]),
                    lists:map(fun(X) -> X * 2 end, ?PARG)), % uses flatten result
```

### Variables

Variables bound outside of the pipeline can be used in the expressions:

```erlang
%% Bound variables used in pipeline expressions
Me = pid_to_list(self()),
[$I,$\ ,$a,$m,$:|Me] = ?PIPE(Me, lists:append(["I am:", ?PARG])),
```

### Composing

As its arguments can be any valid expressions, `?PIPE` can also be used to
compose arbitrary terms and values:

```erlang
%% No func calls, just compose something
#{one := 1, 1 := one} = ?PIPE(one, #{?PARG => 1, 1 => ?PARG}),
```

Including function values:

```erlang
%% Create a nested anonymous function
Upcase_word = ?PIPE(fun(X) when $a =< X,  X =< $z -> X + $A - $a; (X) -> X end,
                    fun(X) -> lists:map(?PARG, X) end),

"ERLANG" = Upcase_word("Erlang"),

["I","LIKE","ERLANG"] = lists:map(Upcase_word, ["I","like","Erlang"]),
```

### Lazy calls

The last random example of `?PIPE` use is getting results from a lazy function.
This is based on the function `ints_from/1` in the `lazy` module of the
[Erlang programming example](https://www.erlang.org/docs/27/system/funs.html#infinite-lists).

To get a list of 5 results at a time, instead of writing something like:

```erlang
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
```

Using `?PIPE` can eliminate the intermediate variables, at the cost of making
the code unreadable:

```erlang
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
```
