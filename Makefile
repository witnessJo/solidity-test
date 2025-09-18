include .env
export

PHONY: all start-evm build deploy call-balance call-send

all: start-evm build deploy

start-evm:
	@echo "Starting local Ethereum node..."
	anvil --chain-id 1337 --port 8545

build:
	@echo "Building the project..."
	forge build

new-nm:
	@echo "Creating a new mnemonic wallet..."
	cast wallet nm --words 12 > "wallet-$$(date +%Y%m%d-%H%M%S).txt"

# Get test ETH from Sepolia faucet
# https://cloud.google.com/application/web3/faucet/ethereum/sepolia
deploy:
	@echo "Deploying the project..."
	forge script script/Deploy.s.sol --broadcast --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

call-mint:
	@echo "Calling mint function..."
	cast send $(CONTRACT_ADDRESS) "mint(address,uint256)" $(RECIPIENT_ADDRESS) 1000000000000000000000 --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

recipt-eth:
	@echo "Getting recipient ether balance..."
	cast balance $(RECIPIENT_ADDRESS) --rpc-url $(RPC_URL)

contract-eth:
	@echo "Getting contract ether balance..."
	cast balance $(CONTRACT_ADDRESS) --rpc-url $(RPC_URL)

second-eth:
	@echo "Getting second address ether balance..."
	cast balance $(SECOND_ADDRESS) --rpc-url $(RPC_URL)

transfer-to-second:
	@echo "Transferring ERC-20 tokens from RECIPIENT to SECOND address..."
	cast send $(CONTRACT_ADDRESS) "transfer(address,uint256)" $(SECOND_ADDRESS) 1000000000000000000 --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

token-balance:
	@echo "Calling token balance function..."
	cast call $(CONTRACT_ADDRESS) "balanceOf(address)" $(RECIPIENT_ADDRESS) --rpc-url $(RPC_URL)

second-token-balance:
	@echo "Getting SECOND address token balance..."
	cast call $(CONTRACT_ADDRESS) "balanceOf(address)" $(SECOND_ADDRESS) --rpc-url $(RPC_URL)

third-token-balance:
	@echo "Calling third address token balance function..."
	cast call $(CONTRACT_ADDRESS) "balanceOf(address)" $(THIRD_ADDRESS) --rpc-url $(RPC_URL)

approve-recipient:
	@echo "SECOND approving RECIPIENT to spend tokens..."
	cast send $(CONTRACT_ADDRESS) "approve(address,uint256)" $(RECIPIENT_ADDRESS) 1000000000000000000 --rpc-url $(RPC_URL) --private-key $(SECOND_PRIVATE_KEY)

send-eth-to-second:
	@echo "Sending ETH to SECOND address for gas..."
	cast send $(SECOND_ADDRESS) --value 0.01ether --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

transfer-from-second:
	@echo "RECIPIENT transferring tokens from SECOND to THIRD..."
	cast send $(CONTRACT_ADDRESS) "transferFrom(address,address,uint256)" $(SECOND_ADDRESS) $(THIRD_ADDRESS) 1000000000000000000 --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

test: build
	@echo "Running tests..."
	forge test -v
