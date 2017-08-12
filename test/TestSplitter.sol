pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Splitter.sol";

contract TestSplitter {

  function testInitialBalancesUsingDeployedContract() {
    uint expected = 10 ether;

    Assert.isTrue(tx.origin.balance >  expected, "Owner should have > 10 Ether initially");
  }

  function testSplitterShouldSplit() {
    Splitter meta = Splitter(DeployedAddresses.Splitter());

    address alice = meta.owner();
    address bob = meta.bob();
    address carol = meta.carol();
    uint aliceBalance = alice.balance;
    uint bobBalance = bob.balance;
    uint carolBalance = carol.balance;

    // this is not yet working (getting an invalid opcode exception). Still trying to figure it out...
    meta.split.value(1 ether)();

    Assert.equal(bob.balance, bobBalance + 0.5 ether, "Bob balance should have 0.5 Ether more");
    Assert.equal(carol.balance, carolBalance + 0.5 ether, "Carol balance should have 0.5 Ether more");
    Assert.equal(alice.balance, aliceBalance - 1 ether, "Alice balance should have 1 Ether less");
  }
}
