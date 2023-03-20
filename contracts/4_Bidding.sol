// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BiddingContract {
    // represents the time when bidding will end
    uint biddingEnds = block.timestamp + 5 days;

    struct HighBidder {
        address bidder;
        string bidderName;
        uint bid;
    }

    // instance of highBidder
    HighBidder public highBidder;

    // events
    // emitted once a bid is received
    event NewHighBid(address indexed who, string name, uint howmuch);
    event BidFailed(address indexed who, string name, uint howmuch);

    modifier timed {
        if (block.timestamp < biddingEnds){
            _; 
        } else {
            revert();
        }
    }

    constructor() {
        highBidder.bid = 1 ether;
    }

    function bid(string memory bidderName) payable public timed {
        // check to see if value exceeds exceeding bid made
        if (msg.value > highBidder.bid) {
            highBidder.bidder = msg.sender;
            highBidder.bidderName = bidderName;
            highBidder.bid = msg.value;

            // received a high bid - emit event
            emit NewHighBid(msg.sender, bidderName, msg.value);
        } else {
            // received lesser bid 
            emit BidFailed(msg.sender, bidderName, msg.value);

            // throw exception
            revert();
        }
    }
}


