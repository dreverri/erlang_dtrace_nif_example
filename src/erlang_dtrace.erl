-module(erlang_dtrace).

-export([log/1]).

-on_load(init/0).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

init() ->
    case code:priv_dir(erlang_dtrace) of
        {error, bad_name} ->
            SoName = filename:join("../priv", erlang_dtrace_drv);
        Dir ->
            SoName = filename:join(Dir, erlang_dtrace_drv)
    end,
    erlang:load_nif(SoName, 0).

log(_Msg) ->
    exit("NIF library not loaded").

%% ===================================================================
%% EUnit tests
%% ===================================================================
-ifdef(TEST).

basic_test() ->
    ok = log("Hello World").

badarg_test() ->
    ?assertException(error, badarg, log(atom)).

-endif.
