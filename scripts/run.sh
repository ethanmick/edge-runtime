#!/bin/bash

<<<<<<< Updated upstream
 cargo build && RUST_LOG=debug RUST_BACKTRACE=full ./target/debug/edge-runtime "$@" start --main-service ./examples/main
=======
# Default values
MAIN_SERVICE="./examples/main"
PORT=9000

cargo build

# Parse command line arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --main-service)
        MAIN_SERVICE="$2"
        shift # past argument
        shift # past value
        ;;
        -p|--port)
        PORT="$2"
        shift # past argument
        shift # past value
        ;;
        *)
        shift # unknown option
        ;;
    esac
done

# Call the executable with the specified or default flags
RUST_BACKTRACE=full ./target/debug/edge-runtime start --main-service "${MAIN_SERVICE}" -p "${PORT}"
>>>>>>> Stashed changes
