pragma solidity ^0.4.24;

import "./ERC721.sol";

contract Item is ERC721{
    
    struct GameItem{
        string name; // Name of the Item
        uint level; // Item Level
        uint rarityLevel;  // 1 = normal, 2 = rare, 3 = epic, 4 = legendary
    }
    
    GameItem[] public items; // First Item has Index 0
    address public owner;
    
    constructor () public {
        owner = msg.sender; // The Sender is the Owner; Ethereum Address of the Owner
    }
    
    function createItem(string _name, address _to) public{
        require(owner == msg.sender); // Only the Owner can create Items
        uint id = items.length; // Item ID = Length of the Array Items
        items.push(GameItem(_name,5,1)); // Item ("Sword",5,1)
        _mint(_to,id); // Assigns the Token to the Ethereum Address that is specified
    }
    function changeOwner(address newOwner) public{
            require(newOwner != address(0), "New owner is the zero address");
        transferOwnership(newOwner);
    }

    function batchMintByOwner(address[] users, uint[] tokenIds) public{
        require(users.length == tokenIds.length, "Users and tokenIds length mismatch");

        for (uint256 i = 0; i < users.length; i++) {
            _mint(users[i], tokenIds[i]);

    }
    function mint() payable public{
        require(msg.value >= mintPrice, "Insufficient Ether sent");
        _mint(msg.sender, nextTokenId);
        nextTokenId++;
    }

    function mintByWhiteList()  public{
        require(whiteList.contains(msg.sender), "You are not in the whitelist");
        _mint(msg.sender, nextTokenId);
        nextTokenId++;

    }

    function addWhiteList(address[] users)  public{
        for (uint256 i = 0; i < users.length; i++) {
            whiteList.add(users[i]);
        }
    }
    function removeWhiteList(address[] users)  public{
        for (uint256 i = 0; i < users.length; i++) {
            whiteList.remove(users[i]);
        }

    }

    function owner(address user)  public view returns (uint[]){
        return _ownedTokens[user];
    }
}