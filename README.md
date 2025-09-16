# WITJ ERC-20 Token Project

A Solidity-based ERC-20 token project using Foundry for development, testing, and deployment on Ethereum Sepolia testnet.

## Token Details

- **Name**: WITJ-ERC20
- **Symbol**: WITJ
- **Total Supply**: 1,000,000 tokens
- **Decimals**: 18 (standard ERC-20)
- **Network**: Sepolia Testnet

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Sepolia testnet ETH for gas fees
- Environment variables configured in `.env`

## Setup

1. Clone and install dependencies:
```shell
git clone <repository-url>
cd solidity-test
forge install
```

2. Configure environment variables in `.env`:
```shell
PRIVATE_KEY=<your-private-key>
RECIPIENT_ADDRESS=<recipient-address>
SECOND_ADDRESS=<second-address>
THIRD_ADDRESS=<third-address>
CONTRACT_ADDRESS=<deployed-contract-address>
RPC_URL=https://eth-sepolia.g.alchemy.com/v2/<your-api-key>
```

## Available Make Commands

### Build and Deploy
```shell
make build          # Compile contracts
make deploy         # Deploy WITJ token to Sepolia
```

### Token Operations
```shell
make call-mint           # Mint 1000 WITJ tokens to RECIPIENT
make transfer-to-second  # Transfer 1 WITJ from RECIPIENT to SECOND
make approve-recipient   # SECOND approves RECIPIENT to spend tokens
make transfer-from-second # RECIPIENT transfers from SECOND to THIRD
```

### Balance Checks
```shell
make token-balance       # Check RECIPIENT token balance
make second-token-balance # Check SECOND token balance
make third-token-balance  # Check THIRD token balance
make recipt-eth          # Check RECIPIENT ETH balance
make second-eth          # Check SECOND ETH balance
```

### Utilities
```shell
make new-nm              # Generate new mnemonic wallet
make send-eth-to-second  # Send ETH to SECOND for gas fees
```

## Workflow Example

1. **Deploy the contract:**
```shell
make deploy
```

2. **Update CONTRACT_ADDRESS in .env with deployed address**

3. **Mint tokens:**
```shell
make call-mint
```

4. **Check balances:**
```shell
make token-balance
make second-token-balance
```

5. **Transfer tokens:**
```shell
make transfer-to-second
make second-token-balance  # Verify transfer
```

6. **Use transferFrom (requires approval):**
```shell
make send-eth-to-second    # Send ETH for gas
make approve-recipient     # Approve spending
make transfer-from-second  # Execute transferFrom
make third-token-balance   # Verify transfer
```

## Contract Functions

- `mint(address to, uint256 amount)` - Mint new tokens
- `transfer(address to, uint256 amount)` - Transfer tokens
- `transferFrom(address from, address to, uint256 amount)` - Transfer with allowance
- `approve(address spender, uint256 amount)` - Approve spending
- `balanceOf(address account)` - Check token balance

## Getting Testnet ETH

Visit these Sepolia faucets to get test ETH:
- [Alchemy Faucet](https://sepoliafaucet.com/)
- [Chainlink Faucet](https://faucets.chain.link/sepolia)
- [QuickNode Faucet](https://faucet.quicknode.com/ethereum/sepolia)
