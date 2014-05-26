%%
%% Simulate a typeahead javascript
%%
%% DynVars used :
%%  - typeahead_min : integer
%%  - typeahead_max : integer
%%  - url : string (required)
%%
%% url = "foobar"
%%
%% will return an erlang List as :
%% ["foo", "foob", "foobar"]
%%
-module(typeahead).
-include_lib("eunit/include/eunit.hrl").
-export([get_urls/1]).
-author({author, "Rodolphe Quiedeville", "<rodolphe@quiedeville.org>"}).

-export([typeahead/1,typeahead/3]).

-ifdef(TEST).
-export([randwait/0,randwait/2,splithead/3,typeahead/5]).
-export([addtime/2,decode/3]).
-endif.

get_urls({_Pid, DynVars})->
    Min = case ts_dynvars:lookup(typeahead_min, DynVars) of
              {ok, Valmin} -> Valmin;
              false -> 2
          end,

    Max = case ts_dynvars:lookup(typeahead_max, DynVars) of
              {ok, Valmax} -> Valmax;
              false -> 8
          end,
    Urls = decode(DynVars, Min, Max),    
    addtime(Urls, []).

addtime([H|T], Acc)->
    lists:merge([[H,randwait()]], addtime(T,Acc));
addtime([],Acc) ->
    Acc.

decode(DynVars, Min, Max)->
    case ts_dynvars:lookup(url, DynVars) of
        {ok, Val} -> typeahead(Val, Min, Max);
        false -> []
    end.

typeahead(List) ->
    typeahead(List, 3, 6).

typeahead(List, Min, Max) ->
    case Min of
        1 -> [H|T] = List;
        _ -> [H,T] = splithead(List, Min, Max)
    end,
    lists:merge([binary:list_to_bin(lists:flatten([H]))],typeahead(T,H,[],2,Max)).

typeahead([H|T], B, Urls, Loop, Max) ->
    case Loop =< Max of
        true ->
            lists:merge(typeahead(T, lists:flatten([B])++lists:flatten([H]), Urls, Loop + 1, Max),
                        [binary:list_to_bin(lists:flatten([B])++lists:flatten([H]))]);
        false -> Urls
    end;

typeahead(_, _, Urls, _, _)->
    Urls.

splithead(List, Len, Max) when length(List) < Max ->
    [string:sub_string(List, 1, Len), string:sub_string(List, 1 + Len, length(List))];
splithead(List, Len, Max) ->
    [string:sub_string(List, 1, Len), string:sub_string(List, 1 + Len, Max)].

%% Random value
%%
%% Return : float
randwait()->
    %%
    %%
    Min=300,
    Max=1000,
    randwait(Min, Max).
%%
%% Random value in a specified range
%%
%% Min : time in millisecond
%%
%% Return : float time in second
randwait(Min, Max)->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    float(max(Min,random:uniform(Max))/1000.0).
