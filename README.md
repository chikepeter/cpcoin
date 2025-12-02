# cpcoin

A simple **cpcoin** fungible token implemented as a Clarity smart contract using Clarinet.

## Project structure

- `Clarinet.toml` – Clarinet project configuration
- `contracts/cpcoin.clar` – cpcoin token smart contract
- `tests/cpcoin.test.ts` – Test scaffold for the cpcoin contract
- `settings/` – Network configuration files

## Requirements

- [Clarinet](https://github.com/hirosystems/clarinet) `>= 3.10.0`
- Node.js and npm (for running tests)

## Getting started

Install dependencies for tests:

```bash path=null start=null
npm install
```

Run the Clarinet checks:

```bash path=null start=null
clarinet check
```

## cpcoin token

The `cpcoin` contract is a basic fungible token with:

- Owner-controlled minting via `mint(recipient, amount)`
- Transfers via `transfer(recipient, amount)`
- Read-only accessors:
  - `get-total-supply()`
  - `get-balance-of(principal)`

### Minting

Only the contract owner (the deployer) may call `mint`. This increases both the recipient’s balance and the global `total-supply`.

### Transfers

`transfer` moves tokens from the caller (`tx-sender`) to `recipient` and fails if the caller does not have enough balance.

## Development workflow

From the project root:

1. **Check contracts**
   ```bash path=null start=null
   clarinet check
   ```

2. **Run tests**
   ```bash path=null start=null
   npm test
   ```

3. **Add more contracts**
   ```bash path=null start=null
   clarinet contract new <contract-name>
   ```
