pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyToken.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        WITJ token = new WITJ(
            "WITJ-ERC20",
            "WITJ",
            1000000, // 1M tokens
            deployer
        );

        vm.stopBroadcast();

        console.log("Token deployed to:", address(token));
        console.log("Owner:", token.owner());
        console.log("Total Supply:", token.totalSupply());
    }
}
