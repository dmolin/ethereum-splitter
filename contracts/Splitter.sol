pragma solidity ^0.4.6;

contract Splitter {
  address public owner;
  address public bob;
  address public carol;

  modifier ifOwner () { require(msg.sender == owner); _; }

  event LogSplit (address sender, uint amount);

  function Splitter (address bobAddress, address carolAddress) {
    owner = msg.sender;
    bob = bobAddress;
    carol = carolAddress;
  }

  function split ()
    public payable
    ifOwner
    returns(bool success)
  {
    // the amount has to be divisible by 2
    require(msg.value % 2 == 0);
    var splitted = msg.value / 2;

    // If I correctly understood, transfer() should rollback the whole
    // transaction if failing to send, so no need to check as with send()
    bob.transfer(splitted);
    carol.transfer(splitted);

    LogSplit(msg.sender, msg.value);
    return true;
  }

  function kill () public ifOwner {
    suicide(owner);
  }

  function () payable {}
}
