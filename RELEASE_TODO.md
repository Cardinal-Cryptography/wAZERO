The release procedure:

1. Compile the current version of the crate within a dockerized build environment.
2. Deploy contracts to Testnet and Mainnet.
3. Prepare a release PR which:
    a. Inserts deployed addresses in `traits.rs` and `README.md`,
    b. Adds `.contract`, `.json` and `.wasm` files to `artifacts`,
    c. Deletes this file.
4. Merge the release PR and tag the resulting commit with `1.0.0`.
5. Publish to crates.io