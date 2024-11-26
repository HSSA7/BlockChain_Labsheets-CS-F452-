// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract Library {
    struct Book {
        string title;
        string author;
        bool isAvailable;
    }

    Book[] public books;
    mapping(address => Book[]) public borrowedBooks;

    event BookAdded(string title, string author);
    event BookBorrowed(address borrower, string title);
    event BookReturned(address borrower, string title);

    // Add a new book to the library
    function addBook(string memory _title, string memory _author) public virtual {
        books.push(Book({
            title: _title,
            author: _author,
            isAvailable: true
        }));
        emit BookAdded(_title, _author);
    }
}

// Derived contract with restricted access
contract ManagedLibrary is Library {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Remove a book (only owner can remove)
    function removeBook(uint _index) public onlyOwner {
        require(_index < books.length, "Invalid index");
        books[_index] = books[books.length - 1]; // Replace with last book
        books.pop(); // Remove the last book
    }
}

// Final derived contract with borrowing functionality
contract DecentralizedLibrary is ManagedLibrary {
    uint public borrowFee = 0.01 ether;
    uint public addBookFee = 0.005 ether; // Fee for adding a book

    // Override addBook to include payment logic
    function addBook(string memory _title, string memory _author) public payable override onlyOwner {
        require(msg.value >= addBookFee, "Insufficient fee to add a book");
        
        // Call the base addBook function to handle book addition
        super.addBook(_title, _author);
    }

    // Borrow a book
    function borrowBook(uint _index) public payable {
        require(_index < books.length, "Book does not exist");
        Book storage book = books[_index];
        require(book.isAvailable, "Book is not available");
        require(msg.value >= borrowFee, "Insufficient fee");

        book.isAvailable = false;
        borrowedBooks[msg.sender].push(book);
        emit BookBorrowed(msg.sender, book.title);
    }

    // Return a book
    function returnBook(uint _index) public {
        require(_index < borrowedBooks[msg.sender].length, "Invalid index");
        Book storage book = borrowedBooks[msg.sender][_index];

        book.isAvailable = true; // Mark the book as available again
        emit BookReturned(msg.sender, book.title);

        // Remove the book from borrowedBooks
        borrowedBooks[msg.sender][_index] = borrowedBooks[msg.sender][borrowedBooks[msg.sender].length - 1];
        borrowedBooks[msg.sender].pop();
    }

    // Withdraw collected fees (only owner)
    function withdrawFees() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
