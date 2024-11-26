// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    // State variable in storage
    struct Person {
        string name;
        uint age;
        address wallet;
    }

    Person public storedPerson; // This is in storage

    // Function to create a person in memory and return it
    function createPerson(string memory _name, uint _age, address _wallet)
        public
        pure
        returns (Person memory)
    {
        Person memory newPerson = Person(_name, _age, _wallet); // This is in memory
        return newPerson; // Return a memory struct
    }

    // Function to set the storage struct
    function setStoredPerson(string memory _name, uint _age, address _wallet) public {
        storedPerson = Person(_name, _age, _wallet); // Set the storage struct
    }
}
