pragma solidity ^0.4.18;
contract SimpleBank {

    mapping (address => bool) public enrolled;
    mapping (address => uint) private balances;
    event LogDepositMade(address accountAddress, uint amount);
    address owner;

    function SimpleBank() public{

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


}
