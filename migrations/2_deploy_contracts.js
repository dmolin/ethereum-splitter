var Splitter = artifacts.require("./Splitter.sol");

module.exports = function(deployer) {
  // we're providing 2 fake user addresses here, that get fed to the contract constructor as "bob" and "alice"
  deployer.deploy(Splitter, "0x8e5e2b55597bb0159a0ec8e581d70038f07db9a6", "0xa75a80b7965569c56114078acb6ada5571e212de");
};
