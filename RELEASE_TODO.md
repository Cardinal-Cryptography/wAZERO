The release procedure:

1. Compile the current version of the crate with `make build`.
2. Deploy contracts to Testnet and Mainnet.
3. Prepare a release PR which:
    a. Inserts deployed addresses in `traits.rs` and `README.md`,
    b. Updates `.contract`, `.json` and `.wasm` files in `artifacts`,
    c. Deletes this file.
4. Merge the release PR and tag the resulting commit with `1.0.0`.
5. Publish to crates.io