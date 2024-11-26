// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfileManager {
    // Struct to represent a user's profile
    struct UserProfile {
        string name; // Name of the user
        string[] hobbies; // Array to store hobbies of the user
    }

    // Mapping from the user's address to their profile
    mapping(address => UserProfile) public profiles;

    // Function to create or update a user profile
    function setUserProfile(string memory _name, string[] memory _hobbies) public {
        UserProfile storage profile = profiles[msg.sender]; // Get the profile for the sender
        profile.name = _name; // Set the name
        profile.hobbies = _hobbies; // Set the hobbies
    }

    // Function to add a hobby to the user's profile
    function addHobby(string memory _hobby) public {
        profiles[msg.sender].hobbies.push(_hobby); // Add hobby to the user's hobbies array
    }

    // Function to get the user's profile
    function getUserProfile() public view returns (string memory name, string[] memory hobbies) {
        UserProfile memory profile = profiles[msg.sender]; // Get the profile for the sender
        return (profile.name, profile.hobbies); // Return name and hobbies
    }
}
