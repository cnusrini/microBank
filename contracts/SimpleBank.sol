pragma solidity ^0.4.18;
contract SimpleBank {

    mapping (address => bool) public enrolled;
    address owner;

    function SimpleBank() public{

        owner = msg.sender;
    }


    /// @enroll() will enroll new customer
    /// @returns sucessfully enrolled customer's status as bool
    /// @Emit's appropriate event
    function enroll() public returns (bool){

      enrolled[msg.sender] = true;

      return enrolled[msg.sender];
    }


}
