-module({{proto_name}}).
-include("{{proto_name}}.hrl").

{{#callback_list}}
-callback {{callback}}({{gpb_proto}}:{{req}}(), ex_msg:state()) -> ex_msg:resp_maps().
{{/callback_list}}
