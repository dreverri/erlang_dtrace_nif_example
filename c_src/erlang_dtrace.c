// DTrace probes
#include "erlang_dtrace_probes.h"

#include "erl_nif.h"

// Prototypes
ERL_NIF_TERM erlang_dtrace_log(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]);

static ErlNifFunc nif_funcs[] =
{
    {"log", 1, erlang_dtrace_log}
};

ERL_NIF_TERM erlang_dtrace_log(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    char msg[4096];

    if (enif_get_string(env, argv[0], msg, sizeof(msg), ERL_NIF_LATIN1)) {
        ERLANG_DTRACE_LOG(msg);
        return enif_make_atom(env, "ok");
    } else {
        return enif_make_badarg(env);
    }
}

ERL_NIF_INIT(erlang_dtrace, nif_funcs, NULL, NULL, NULL, NULL);
