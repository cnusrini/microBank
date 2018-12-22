pragma solidity ^0.4.18;
contract microBank {

    mapping (address => bool) public enrolled;
    mapping (address => uint) private balances;
    event LogDepositMade(address accountAddress, uint amount);
    address owner;

    function microBank() public{

        owner = msg.sender;
    }


    // enroll will enroll new customer
    // returns sucessfully enrolled customer's status as bool
    // Emit's appropriate event
    function enroll() public returns (bool){

      enrolled[msg.sender] = true;

      return enrolled[msg.sender];
    }


    // return The balance of the user after the deposit is made -- completed task
    // Add the appropriate keyword so that this function can receive ether-- completed task
    // Use the appropriate global variables to get the transaction sender -- completed task
    // Use the appropriate global variables to get the value -- completed task
    // Emit the appropriate event -- completed task

    function deposit() public payable returns (uint bal) {
      //Using require to verify any potential overflow issues
      require((balances[msg.sender]+ msg.value) >= balances[msg.sender]);
      balances[msg.sender] += msg.value;
      LogDepositMade(msg.sender, msg.value);

      bal = balances[msg.sender];

      return bal;
    }

    // notice Get balance -- Information
    // return The balance of the user -- Task completed
    // A SPECIAL KEYWORD prevents function from editing state variables; -- Task completed
    // allows function to run locally/off blockchain -- Task completed

    function balance() view public returns (uint) {

        return balances[msg.sender];
    }

    // notice Withdraw ether from bank
    // dev This does not return any excess ether sent to it
    // param withdrawAmount amount you want to withdraw
    // return The balance remaining for the user
    // Emit the appropriate event

    function withdraw(uint withdrawAmount) public payable returns (uint bal) {
        /* If the sender's balance is at least the amount they want to withdraw,
           Subtract the amount from the sender's balance, and try to send that amount of ether
           to the user attempting to withdraw.
           return the user's balance.*/
           require(withdrawAmount > 0);
           require(withdrawAmount < balances[msg.sender]);
           msg.sender.transfer(withdrawAmount);
           balances[msg.sender] -= withdrawAmount;
           bal = balances[msg.sender];
           return bal;
    }

    // Fallback function - Called if other functions don't match call or
    // sent ether without data
    // Typically, called when invalid data is sent
    // Added so ether sent to this contract is reverted if the contract fails
    // otherwise, the sender's money is transferred to contract
    //7
    function() public{
      revert();
    }


}
