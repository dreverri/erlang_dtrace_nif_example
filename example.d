#!/usr/sbin/dtrace -Z -s
#
# example.d - Example D script
#
# Start this script - "./example.d"
# Run eunit tests - "./rebar compile eunit"
# The eunit tests will output "Hello World" to dtrace
# The example script will pick up the eunit test output

dtrace:::BEGIN
{
    printf("Waiting... Hit Ctrl-C to end.\n");
}

erlang_dtrace*:::*
{
    printf("%s", copyinstr(arg0));
}
