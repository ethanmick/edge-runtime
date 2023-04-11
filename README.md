# Supabase Edge Runtime

A Javascript runtime based on [Deno](https://deno.land), capable of running JavaScript, TypeScript, and WASM services.

You can use it to:

* Locally test and self-host Supabase's Edge Functions (or any Deno Edge Function)
* As a programmable HTTP Proxy: You can intercept / route HTTP requests

**WARNING: Beta Software. There will be breaking changes to APIs / Configuration Options**

## Architecture

The edge runtime is divided into two runtimes, similar in code with different purposes.
- Main runtime:
  - An instance for the _main runtime_ is responsible for proxying the transactions to the _user runtime_. 
  - The main runtime can constantly change in its behavior, and it is not meant to run users' code.
  - Has no user-facing limits
- User runtime:
  - An instance for the _user runtime_ is responsible for executing users' code.
  - Limits are required to be set such as: Memory & Timeouts
  - Environmental Variables are readonly.

## Current Work

- HTTP proxy
  - Requests are proxied and a new isolate of the User Runtime is spun to handle the request

- Snapshots
  - Internal code is snapshotted with V8 in order to optimize the boot time & have previous control on the behavior of internal runtime functionality

- Cross Compatability
  - Deno Edge Functions are cross-compatible with Supabase's Edge runtime

## Benchmarks

Build benchmarks can be tracked by 
```sh
cargo build --timings
```

## How to run locally
To serve all functions in the examples folder, you can do this with the [example main service](./examples/main/index.ts) provided with this repo
```sh
./run.sh start --main-service ./examples/main -p 9000
```

Test by calling the [hello world function](./examples/hello-world/index.ts)
```sh
curl --request POST 'http://localhost:9000/hello-world' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "John Doe"
}'
```

To run with a different entry point, you can pass a different main service like below
```
./run.sh start --main-service /path/to/main-service-directory -p 9000
```

using Docker:

```
docker build -t edge-runtime .
docker run -it --rm -p 9000:9000 -v /path/to/supabase/functions:/usr/services supabase/edge-runtime start --main-service /usr/services
```

## How to run tests

Read about running tests [here](https://github.com/supabase/edge-runtime/blob/main/testing.md)

## How to update to a newer Deno version

* Select the Deno version to upgrade and visit its tag on GitHub (eg: https://github.com/denoland/deno/blob/v1.30.3/Cargo.toml)
* Open the `Cargo.toml` at the root of of this repo and modify all `deno_*` modules to match to the selected tag of Deno.

## Contributions

We welcome contributions to Supabase Edge Runtime!

To get started either open an issue on [GitHub](https://github.com/supabase/edge-runtime/issues) or drop us a message on [Discord](https://discord.com/invite/R7bSpeBSJE)

Edge Runtime follows Supabase's [Code of Conduct](https://github.com/supabase/.github/blob/main/CODE_OF_CONDUCT.md).
