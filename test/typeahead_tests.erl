%%
%% @doc erlang module to simulate typeahead
%%
%% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%%   [http://rodolphe.quiedeville.org]
%%
%% @copyright 2014 Rodolphe Quiedeville
%%

-module(typeahead_tests).
-include_lib("eunit/include/eunit.hrl").

%% tests
%%
%% Function tested : typeahead/3
%%
%%

typeahead_test() ->
    Result = length(typeahead:typeahead("belleville", 2, 4)),
    Attend = 3,
    ?assertEqual(Attend, Result).

%%
%% Function tested : typeahead/3
%%
%%

typeahead_minone_test() ->
    %% the minimal is one
    Result = length(typeahead:typeahead("belleville", 1, 4)),
    Attend = 4,
    ?assertEqual(Attend, Result).
%%
%% Function tested : typeahead/3
%%
%%
typeahead_minzero_test() ->
    %% the minimal is zero
    Result = length(typeahead:typeahead("belleville", 0, 4)),
    Attend = 4,
    ?assertEqual(Attend, Result).

%% typeahead/5
%%
%%
typeahead_main_test() ->
    %% the main test
    Result = typeahead:typeahead([],3,["lorem"], 3, 3),
    Attend = ["lorem"],
    ?assertEqual(Attend, Result).
%% Loop initialisation
%%
%%
typeahead_init_test() ->
    %% the main test
    Result = typeahead:typeahead("orem","l",[], 2, 4),
    [[<<"lo">>, Rand1], [<<"lor">>, _], [<<"lore">>,_]] = Result,
    ?assertEqual(true, is_integer(Rand1)).
%%
%% Function tested : typeahead/1
%%
%%
typeahead_default_test() ->
    [[Url,_]|_] = typeahead:typeahead("belleville"),
    ?assertEqual(<<"bell">>, Url).

typeahead_default_small_test() ->
    Result = typeahead:typeahead("foo"),
    Attend = [<<"foo">>],
    ?assertEqual(Attend, Result).
%%
%% splithead/3
%%
splithead_test() ->
    Result = typeahead:splithead("belleville", 2, 6),
    Attend = ["be", "llev"],
    ?assertEqual(Attend, Result).
%%
%% splithead/3
%% the string is shorter than max limit
splithead_short_test() ->
    Result = typeahead:splithead("belle", 2, 6),
    Attend = ["be", "lle"],
    ?assertEqual(Attend, Result).


randwait_test() ->
    Result = is_integer(typeahead:randwait(2, 6)),
    Attend = true,
    ?assertEqual(Attend, Result).

randwait_min_test() ->
    Min = 2,
    Result = typeahead:randwait(Min, 6) >= Min,
    Attend = true,
    ?assertEqual(Attend, Result).

randwait_max_test() ->
    Max = 5,
    Result = typeahead:randwait(2, Max) =< Max,
    Attend = true,
    ?assertEqual(Attend, Result).

decode_test() ->
    %% the tsung call
    Dynvars = [{url, "lorem"}],
    Result = typeahead:decode(Dynvars, 2, 4),
    Attend = [<<"lo">>,<<"lor">>,<<"lore">>],
    ?assertEqual(Attend, Result).

decode_urlempty_test() ->
    %% url is not set in tsung scenario
    Dynvars = [],
    Result = typeahead:decode(Dynvars, 1, 2),
    Attend = [],
    ?assertEqual(Attend, Result).

geturl_test() ->
    %% the tsung call
    Dynvars = [{url, "lorem"}],
    Result = typeahead:decode(Dynvars, 2, 4),
    Attend = [<<"lo">>,<<"lor">>,<<"lore">>],
    ?assertEqual(Attend, Result).
