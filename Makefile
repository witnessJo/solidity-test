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

deploy:
	@echo "Deploying the project..."
	forge script script/Deploy.s.sol --broadcast --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

call-balance:
	@echo "Calling balance function..."
	cast balance $(CONTRACT_ADDRESS) --rpc-url $(RPC_URL)

call-send:
	@echo "Calling send function..."
	cast send $(CONTRACT_ADDRESS) --rpc-url $(RPC_URL) --value 0.0000001ether --private-key $(PRIVATE_KEY) $(CONTRACT_ADDRESS)jj

call-transfer:
	@echo "Calling transfer function..."
	cast send $(CONTRACT_ADDRESS) "transfer(address,uint256)" $(RECIPIENT_ADDRESS) 1ether --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

call-transferFrom:
	@echo "Calling transferFrom function..."
	cast send $(CONTRACT_ADDRESS) "transferFrom(address,address,uint256)" $(SENDER_ADDRESS) $(RECIPIENT_ADDRESS) 0.0000001ether --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)

call-mint:
	@echo "Calling mint function..."
	cast send $(CONTRACT_ADDRESS) "mint(address,uint256)" $(RECIPIENT_ADDRESS) 1000 --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)
