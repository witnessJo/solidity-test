pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/WIJToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WIJTokenTest is Test {
    WITJ public token;
    address public owner;
    address public user1;
    address public user2;

    function setUp() public {
        owner = address(0x1);
        user1 = address(0x2);
        user2 = address(0x3);

        // print owner address
        console.log("Owner address:", owner);
        console.log("User1 address:", user1);
        console.log("User2 address:", user2);

        vm.prank(owner);
        token = new WITJ("WITJ-ERC20", "WITJ", 1000000, owner); // 1M tokens
    }
    function test_InitialSupply() public {
        uint256 expectedSupply = 1000000 * 10 ** token.decimals();
        console.log("Expected Supply:", expectedSupply);
        assertEq(token.totalSupply(), expectedSupply);
        assertEq(token.balanceOf(owner), expectedSupply);
    }
    function test_MintByOwner() public {
        uint256 mintAmount = 5000 * 10 ** token.decimals();
        vm.prank(owner);
        token.mint(user1, mintAmount);
        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.totalSupply(), (1000000 * 10 ** token.decimals()) + mintAmount);
    }

    function test_MintByNonOwner() public {
        uint256 mintAmount = 5000 * 10 ** token.decimals();
        vm.prank(user1);
        vm.expectRevert();
        token.mint(user1, mintAmount);
    }
    function test_BurnByHolder() public {
        uint256 burnAmount = 2000 * 10 ** token.decimals();
        vm.prank(owner);
        token.transfer(user1, burnAmount);
        vm.prank(user1);
        token.burn(burnAmount);
        assertEq(token.balanceOf(user1), 0);
        assertEq(token.totalSupply(), (1000000 * 10 ** token.decimals()) - burnAmount);
    }
}

