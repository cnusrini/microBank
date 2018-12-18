var SimpleBank = artifacts.require("./SimpleBank.sol");
var assert = require('assert');

contract('Unit test for isEnrolled?', function(accounts) {

  const owner = accounts[0];
  const cust1 = accounts[1];
  let deployedContract;

  beforeEach('ITs deploy SimpleBank smart contract', async () => {
    deployedContract = await SimpleBank.deployed();
  });

  it('tests for positive test', async () => {

    const enrolled = await deployedContract.enroll({from: cust1});
    const didCustEnrolled = await deployedContract.enrolled(cust1);

    assert.equal(didCustEnrolled, true, "ssss");

  });

  it('tests for negative test', async () => {
    const isOnwerEnrolled = await deployedContract.enrolled(owner);

    assert.equal(isOnwerEnrolled, false);
  });
});
