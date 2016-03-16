-module(xml_server_worker).
-behavior(gen_server).

% API
-export([start_link/0,
	 stop/0,
	 parse/1
	]).

% Gen Server functions
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3
	]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Server functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

stop() -> gen_server:call(?MODULE, stop).

parse(Bin) -> gen_server:call(?MODULE, {parse, Bin}).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gen Server callback functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

init([]) -> {ok, []}.

handle_call({parse, Bin}, _, State) ->
    Reply = parsexml:parse(Bin),
    {reply, Reply, State};

handle_call(stop, _, State) -> {stop, normal, State}.

% Not handled callback functions
handle_cast(Cast, State) -> {stop, {"Can not handle cast", Cast}, State}.
handle_info(Info, State) -> {stop, {"Can not handle info", Info}, State}.
terminate(_, _) -> ok.
code_change(_, State, _) -> {ok, State}.
