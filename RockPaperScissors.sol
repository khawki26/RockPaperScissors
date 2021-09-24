pragma solidity 0.6.0;

contract RockPaperScissors {
    bytes32 constant ROCK = "ROCK";
    bytes32 constant PAPER = "PAPER";
    bytes32 constant SCISSORS = "SCISSORS";

    mapping(address => bytes32) public choices;

    function play(bytes32 choice) external {
        

        require(choices[msg.sender] == bytes32(0)); // First time player is playing.
        choices[msg.sender] = choice;
    }

    function evaluate(
        address player1,
        bytes32 player1Choice,
        bytes32 player1Randomness, 
        address player2,
        bytes32 player2Choice,
        bytes32 player2Randomness 
    ) external view returns (address) {
        //  Choice is shown
        require(
            keccak256(abi.encodePacked(player1Choice, player1Randomness)) ==
                choices[player1]
        );

        // check that player2 isn't cheating
        require(
            keccak256(abi.encodePacked(player2Choice, player2Randomness)) ==
                choices[player2]
        );

        // draw if they pick the same
        if (player1Choice == player2Choice) {
            return address(0);
        }

        if (player1Choice == ROCK && player2Choice == PAPER) {
            return player2;
        } else if (player2Choice == ROCK && player1Choice == PAPER) {
            return player1;
        } else if (player1Choice == SCISSORS && player2Choice == PAPER) {
            return player1;
        } else if (player2Choice == SCISSORS && player1Choice == PAPER) {
            return player2;
        } else if (player1Choice == ROCK && player2Choice == SCISSORS) {
            return player1;
        } else if (player2Choice == ROCK && player1Choice == SCISSORS) {
            return player2;
        }
    }
}