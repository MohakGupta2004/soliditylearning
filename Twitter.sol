
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter{
    struct Tweet{
        uint id;
        address author;
        string content;
        uint timestamp;
        uint likes;
    }
    mapping (address => Tweet[]) public tweets;
    uint MAX_TWEET_LENGTH = 10;
    address public owner;
    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }
    function changeTweetLength(uint len) public onlyOwner {
        MAX_TWEET_LENGTH = len;
    }
    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length<MAX_TWEET_LENGTH);
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }
    function getTweet(uint _i) public view returns (Tweet memory) {
        require(_i < tweets[msg.sender].length, "Tweet does not exist."); // Check if the index is valid
        return tweets[msg.sender][_i];
    }
    function getAllTweet(address _owner) public view returns(Tweet[] memory){
        return tweets[_owner];
    }
    // Helper function to check the number of tweets for a given address
    function getTweetCount(address _owner) public view returns (uint) {
        return tweets[_owner].length;
    }

    function likeTweet(uint id, address author) external {
        require(author != msg.sender);
        tweets[author][id].likes++;
    }

    function unlikeTweet(uint id, address author) external{
        require(tweets[author][id].likes>0);
        tweets[author][id].likes--;
    }

}
