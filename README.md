Rebar3 gpb rpc plugin
=====

A rebar3 plugin for automatically compiling .proto files using the gpb protobuf compiler
This plugin base on lrascao's [rebar3_gpb_plugin](https://github.com/lrascao/rebar3_gpb_plugin/) `1.8.2`

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

    {erl_opts, [{i, "./_build/default/plugins/gpb/include"}]}.

    {plugins, [
        { rebar3_gpb_plugin, "1.8.2" },
        {rebar3_gpb_rpc_plugin, {git, "git://github.com/feng19/rebar3_gpb_rpc_plugin", {branch, "master"}}}
    ]}.

Configure gpb options (example below), full list can consulted on [gpb's project page](https://github.com/tomas-abrahamsson/gpb) [gpb_compile:file/2](https://github.com/tomas-abrahamsson/gpb/blob/3.19.0/src/gpb_compile.erl#L66-L93):

    {gpb_opts, [
        {i, "path/to/proto_dir"},
        {module_name_suffix, "_pb"},
        {o_erl, "path/to/out_src"},
        {o_hrl, "path/to/out_include"},
        {strings_as_binaries, true},
        type_specs]}.

    {gpb_rpc_opts, [
        {h_msg, "msg"},
        {o_erl, "src/rpc_msg"},
        {o_hrl, "include/rpc_msg"}
    ]}.

The `i`, `o_erl` and `o_hrl` option values are relative to the app's location.
Default values are:
    * `{i, "proto"}`
    * `{o_erl, "src"}`
    * `{o_hrl, "include"}`

Plugin specific options (can be used together the gpb ones):

    {gpb_opts, [
        {recursive, boolean()},
        {ipath, "path/to/another/proto_dir"}
    ]}.

* `{recursive, boolean()}` - look recursively through the provided folders
  to look for .proto files (default is true)
* `{ipath, "path/to/another/proto_dir"}` - paths that are to be added to gpb's
  include path but not searched for .proto files (useful for importing .proto
  files from other .proto).

Add the gpb include path (environment tipically is default):

    {erl_opts, [{i, "./_build/<environment>/plugins/gpb/include"}]}.

Add a hook to automatically generate modules for your protobuf files and clean them afterwards:

    {provider_hooks, [
        {pre, [
            {compile, {protobuf, compile}},
            {compile, {gpb_rpc, compile}},
            {clean, {protobuf, clean}},
            {clean, {gpb_rpc, clean}}
        ]}
    ]}.
