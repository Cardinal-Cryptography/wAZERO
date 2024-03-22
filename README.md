# Wrapped AZERO

This repository contains an [ink!][ink] smart contract for [Aleph Zero][aleph] blockchain which allows to wrap the native chain coin (AZERO) into a fungible token following [PSP22][psp22] standard.

The contract is deployed to both test and main networks under the following addresses:
 - Aleph Zero Mainnet: `[TODO]`
 - Aleph Zero Testnet: `[TODO]`

The [`artifacts`][artifacts] folder contains the exact compiled binary that has been deployed, as well as all other compilation artifacts for verification purposes.

The contents of this repository has been published to [crates.io][wazero-crates] to allow for easy integration from other smart contracts thanks to `WrappedAZERO` trait.

## How to interact with Wrapped AZERO from other contracts

1. Add the [wrapped-azero][wazero-crates] dependency in your project's `Cargo.toml`:
```TOML
wrapped-azero = { version = "1.0", default-features = false }
# ...
[features]
# ...
std = [
    # ...
    "wrapped-azero/std",
]

```

2. To call `deposit` and `withdraw` methods from your contract, use the [`contract_ref`][contract_ref] macro with `WrappedAZERO` trait:
```rust
use ink::{codegen::TraitCallBuilder, contract_ref};
use wrapped_azero::{WrappedAZERO, MAINNET};

let mut wazero: contract_ref!(WrappedAZERO) = MAINNET.into();
wazero.withdraw(amount); // returns Result<(), PSP22Error>

// Deposit call must be composed manually to be able to attach AZERO transfer
wazero.call_mut().deposit().transferred_value(amount).invoke(); // returns Result<(), PSP22Error>

```

3. To call regular PSP22 methods (transfers, balances, approvals) from your contract, use the [`contract_ref`][contract_ref] macro with `PSP22` trait:
```rust
use ink::contract_ref;
use ink::prelude::vec;
use wrapped_azero::{PSP22, MAINNET};

let mut wazero: contract_ref!(PSP22) = MAINNET.into();
let balance = wazero.balance_of(some_account);
wazero.transfer(recipient, value, vec![]); // returns Result<(), PSP22Error>
```

## How to interact with Wrapped AZERO manually via web interface

1. Go to [Contracts UI][contracts-ui].
2. Select "Aleph Zero" (or "Aleph Zero Testnet") from the networks menu in top left corner.
3. Choose "Add New Contract" and then "Use On-Chain Contract Address".
4. Paste the Mainnet (Testnet) address listed above.
5. Choose any name you like and use the metadata JSON file from [`artifacts`][artifacts] folder.
6. Choose the caller and the method to call. For read-only methods (like `psp22::balanceOf`) you will see the response immediately. For other methods fill in the parameters (leave all the limits with their default values) and sign the transaction (you need to have Aleph Zero Signer or similar browser extension connected with Contracts UI).

[traits]: ./traits.rs
[artifacts]: ./artifacts
[wazero-crates]: https://crates.io/crates/wrapped-azero
[aleph]: https://alephzero.org/
[ink]: https://use.ink
[psp22]: https://github.com/inkdevhub/standards/blob/master/PSPs/psp-22.md
[contract_ref]: https://paritytech.github.io/ink/ink/macro.contract_ref.html
[contracts-ui]: https://contracts-ui.substrate.io