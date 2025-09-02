(
 (nil . (
         (wj/project-run-default-dir . "/home/witnessjo/dev/solidity-test/")
         (wj/project-run-command . "none")
         (eval . (progn
                   (setq wj/project-subcmds
                         (list
                          (list "start evm" "anvil" "/home/witnessjo/dev/solidity-test/")
                          (list "build" "forge build" "/home/witnessjo/dev/solidity-test/")
                          (list "send" "cast send --rpc-url http://localhost:8545 --value 1ether --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 0xff4505fB31674A563665484FA338e710C1101Ef3" "/home/witnessjo/dev/solidity-test/")
                          (list "deploy" "forge script script/Deploy.s.sol --rpc-url http://localhost:8545 --broadcast -vvvv" "/home/witnessjo/dev/solidity-test/")
                          (list "call-balance" "cast call 0x61cbd28f4b8feadc81438b4a89b6198d854da6f031e121022534a5a2be5853ae balance" "/home/witnessjo/dev/solidity-test/")
                          ))))
         )
      )
 )
