var microBank = artifacts.require("./microBank.sol");

module.exports = function(deployer) {
  deployer.deploy(microBank);

};
