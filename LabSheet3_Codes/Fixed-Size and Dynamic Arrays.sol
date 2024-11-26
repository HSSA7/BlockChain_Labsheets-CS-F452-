// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Fixed-size array
uint[3] fixedArray = [1, 2, 3]; // Direct initialization

// Function to initialize a fixed array if needed with a loop
function initializeFixedArray() public {
    for (uint i = 0; i < fixedArray.length; i++) {
        fixedArray[i] = (i + 1) * 10; // This will set fixedArray to [10, 20, 30]
    }
}

// Dynamic array
uint[] public dynamicArray;

// Function to initialize a dynamic array
function initializeDynamicArray() public {
    for (uint i = 0; i < 3; i++) {
        dynamicArray.push((i + 1) * 10); // Adds 10, 20, 30 to the dynamic array
    }
}

// Function to access and extend the dynamic array
function extendDynamicArray() public {
    dynamicArray.push(40); // Adds 40 to the dynamic array
    // Now dynamicArray contains [10, 20, 30, 40]
    dynamicArray.pop(); // Removes the last element
    // Now dynamicArray contains [10, 20, 30]
}
