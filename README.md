xml_server
=====

OTP XML to proplist parsing server


An OTP application to be embedded in a larger application.

The role of this application is to provide an XML to proplist parsing server.

    1> application:start(xml_server).
    ok

    2> xml_server_worker:parse(<<"XML content">>).
    ...

In your rebar.config:

    {deps, [
        {xml_server, {git, "git://github.com/rbenaley/xml_server", {branch, master}}}
    ]}.

In your src/yourapp.app.src:

      {applications,
       [kernel,
        stdlib,
        xml_server
       ]},

Of course this OTP application is composed of an application, a supervisor and a gen_server.

Please note that this module is designed to work with rebar3 exclusively.

Build
-----

    $ rebar3 compile
