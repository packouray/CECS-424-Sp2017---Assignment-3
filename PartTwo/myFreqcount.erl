-module(myFreqcount).
-export([parseFile/1,countWords/2,myHash/1,start/0]).

% This function get the frequence of each words contained in the List.
countWords(My_key,List) ->
  case lists:keyfind(My_key,1,List) of
    {My_key,Val} -> lists:keyreplace(My_key,1,List,{My_key,Val+1});
    false -> lists:append(List,[{My_key,1}])
  end.

% This function open and parse the mentionned file.
parseFile(FileName) ->
  {ok, Device} = file:open(FileName,[read]),
  Data = io:get_line(Device, ""),
  S = string:tokens(Data, ",.\n _: 0123456789"),
  S.

myHash(MyList) ->
  lists:foldl(fun(My_key,List)-> countWords(string:to_lower(My_key),List) end, [], MyList).

% This function call and run the principal function of the program.
start() ->
  ParsedWords = parseFile("assignment3-part2.txt"),
  TupList = myHash(ParsedWords),
  io:fwrite("~p~n",[lists:reverse(lists:keysort(2,TupList))]).
