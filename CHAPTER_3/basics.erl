-module(basics).
-export([
         house_floors/1,
         example_house/0,
         street/0
        ]).

house_floors(House) ->
    {_, _, _, {floors, Floors}} = House,
    Floors.

example_house() ->
    {house, {owner, peter}, {color, red}, {floors, 2}}.

street() ->
    [
    {house, {owner, peter}, {color, red}, {floors, 2}},
    {house, {owner, peter}, {color, red}, {floors, 2}},
    {house, {owner, peter}, {color, red}, {floors, 2}}
    ].
