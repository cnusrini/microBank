var SimpleBank = artifacts.require("./microBank.sol");
var assert = require('assert');

contract('Unit test for isEnrolled?', function(accounts) {

  // owner is one who deployed the contract.
  // In business terms owner is the owner of the back.
  const owner = accounts[0];
  const cust1 = accounts[1];
  const depositedValue = web3.toBigNumber(2);

  let deployedContract;
  let didCustEnrolled;

  beforeEach('deploy the smart contract', async () => {
    deployedContract = await SimpleBank.deployed();
  });
  it('tests for positive tests', async () => {

    const enrolled = await deployedContract.enroll({from: cust1});
    didCustEnrolled = await deployedContract.enrolled(cust1);

    assert.equal(didCustEnrolled, true, "ssss");

  });

  it('tests for negative tests', async () => {

    const didOwnerEnrolled = await deployedContract.enrolled(owner);

    assert.equal(didOwnerEnrolled, false, 'this customer is not enrolled with this bank');
  });

  it('tests for deposit made and theri bank balance', async () => {
      if(didCustEnrolled){
        await deployedContract.deposit({from: cust1, value: depositedValue});
        const balance = await deployedContract.balance({from: cust1});

        assert.equal(depositedValue.toString(), balance, ' returing correct bank balance ')

        const expectedEvent = {accountAddress: cust1, value: depositedValue};
        const actualEvent = await deployedContract.LogDepositMade();
        const log = await new Promise(function(resolve, reject){
          actualEvent.watch(function(error , log){
            resolve(log);
          });
        });

        const addressFrmActualEvent = log.args.accountAddress;
        const valueFrmActualEvent = log.args.amount.toString();

        assert.equal(expectedEvent.accountAddress, addressFrmActualEvent, 'address is correct');
        assert.equal(expectedEvent.value , valueFrmActualEvent, ' value deposited is correct');

      }
      else{
        console.log('print didCustEnrolled in else' + didCustEnrolled);
      }

  });
});
