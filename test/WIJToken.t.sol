pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/WIJToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WIJTokenTest is Test {
    WITJ public token;
    address public owner;
    address public user1;
    address public user2;
    // expected supply after initial mint
    uint256 public expectedInitialSupply;

    function setUp() public {
        owner = address(0x1);
        user1 = address(0x2);
        user2 = address(0x3);
        expectedInitialSupply = 1000000 * 10 ** 18; // 1M tokens with 18 decimals

        // print owner address
        console.log("Owner address:", owner);
        console.log("User1 address:", user1);
        console.log("User2 address:", user2);
        console.log("Expected Initial Supply:", expectedInitialSupply);

        vm.prank(owner);
        token = new WITJ("WITJ-ERC20", "WITJ", 1000000, owner); // 1M tokens
    }
    function test_InitialSupply() public {
        console.log("Expected Supply:", expectedInitialSupply);
        assertEq(token.totalSupply(), expectedInitialSupply);
        assertEq(token.balanceOf(owner), expectedInitialSupply);
    }
    function test_MintByOwner() public {
        uint256 mintAmount = 5000 * 10 ** token.decimals();
        vm.prank(owner);
        token.mint(user1, mintAmount);
        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.totalSupply(), (expectedInitialSupply + mintAmount));
    }
    function test_MintByNonOwner() public {
        uint256 mintAmount = 5000 * 10 ** token.decimals();
        vm.prank(user1);
        vm.expectRevert();
        token.mint(user1, mintAmount);
    }
    function test_Transfer() public {
        uint256 transferAmount = 3000 * 10 ** token.decimals();
        vm.prank(owner);
        token.transfer(user1, transferAmount);
        assertEq(token.balanceOf(user1), transferAmount);
        assertEq(token.balanceOf(owner), (expectedInitialSupply - transferAmount));
    }
    function test_Allowance() public {
        uint256 approveAmount = 2000 * 10 ** token.decimals();
        vm.prank(owner);
        token.approve(user1, approveAmount);
        console.log("Allowance of user1 by owner:", token.allowance(owner, user1));
        assertEq(token.allowance(owner, user1), approveAmount);
    }
    function test_TranferFrom() public {
        uint256 transferAmount = 4000 * 10 ** token.decimals();
        vm.prank(owner);
        token.approve(user1, transferAmount);
        vm.prank(user1);
        token.transferFrom(owner, user2, transferAmount);
        assertEq(token.balanceOf(user2), transferAmount);
        assertEq(token.balanceOf(owner), (expectedInitialSupply) - transferAmount);
    }
}
