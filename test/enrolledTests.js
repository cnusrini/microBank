var SimpleBank = artifacts.require("./SimpleBank.sol");
var assert = require('assert');

contract('Unit test for isEnrolled?', function(accounts) {

  const cust1 = accounts[1];

  it('tests for positive test', async () => {
    const deployedContract = await SimpleBank.deployed();
    const enrolled = await deployedContract.enroll({from: cust1});
    const didCustEnrolled = await deployedContract.enrolled(cust1);

    assert.equal(didCustEnrolled, true, "ssss");

  });
});
