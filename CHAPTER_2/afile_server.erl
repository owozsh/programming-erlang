-module(afile_server).
-export([
         start/1,
         loop/1
        ]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
    receive
        {Client, list_dir} ->
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            Full = filename:join(Dir, File),
            Client ! {self(), file:read_file(Full)};
        {Client, {put_file, FileName, Text}} ->
            FilePath = filename:join(Dir, FileName),

            case unicode:characters_to_binary(Text, unicode, utf8) of
                Bytes when is_binary(Bytes) ->
                    Client ! {self(), file:write_file(FilePath, Bytes)};
                _ ->
                    Client ! {self(), {error, "Error"}}
            end
    end,
    loop(Dir).
