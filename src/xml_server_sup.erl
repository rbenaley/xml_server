%%%-------------------------------------------------------------------
%% @doc xml_server top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(xml_server_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1, stop/0]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    {ok, {{one_for_one, 5, 2000},
        [child(xml_server_worker)]}}.

stop() -> exit(whereis(?MODULE), shutdown).

%%====================================================================
%% Internal functions
%%====================================================================
child(Module) ->
    {Module, {Module, start_link, []}, permanent, brutal_kill, worker, [Module]}.
