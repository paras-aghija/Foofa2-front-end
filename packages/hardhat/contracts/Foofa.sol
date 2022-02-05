
pragma solidity 0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";

contract FooFa is ERC1155, ERC1155Holder {

    constructor() ERC1155("") {}


    mapping(address=> uint) public balances;
    uint public counter=1;
    mapping(address =>mapping(uint=> Listing)) public ListingDetails;
    mapping(address=> mapping(uint=> uint )) public NFTPurchasePrice;


    
    
    


    struct Listing{
        uint256 price;
        address seller;
        uint counter;
        uint discount;
        uint amount;
        uint noOftokens;


    }

   

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155,ERC1155Receiver) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
    
 


    mapping(address => mapping(uint256 => Listing)) public listings;
    mapping(address=> mapping(uint=> uint)) public TokensOwnership;

    function NFTbuy(address contractAddress, uint tokenId,uint amountOfNFT) public payable  {
        Listing memory item = ListingDetails[contractAddress][tokenId];
        ERC1155 token = ERC1155(contractAddress);
        require(token.balanceOf(address(this),tokenId)>=1);
        require(msg.value >= item.price * amountOfNFT,"Not enough ether sent");
        token.safeTransferFrom(address(this),msg.sender,tokenId,amountOfNFT,"");
        NFTPurchasePrice[contractAddress][tokenId]= msg.value;
       
        

    }
    function addListing(uint price, uint tokenId, address contractAddress,uint8 NoOfTokens,uint amount,uint discount) public payable {
        ERC1155 token = ERC1155(contractAddress);
        token.safeTransferFrom(msg.sender,address(this),tokenId,amount, "");
        MintafterNFtreceieved(msg.sender,counter,NoOfTokens,"");
        ListingDetails[contractAddress][tokenId]= Listing(price,msg.sender,counter,discount,amount,NoOfTokens);
        counter++;



    }



    function MintafterNFtreceieved(address to, uint id, uint amount,bytes memory  data) internal {
        _mint(to,id,amount,data);
        
    }

    function sellTokens(uint _counter, uint amountOfTokens) public  payable {
        require(balanceOf(msg.sender,_counter)>=amountOfTokens);
        safeTransferFrom(msg.sender,address(this),_counter,amountOfTokens,"");
    } 

    function buyTokens(uint _counter,uint _amountOfTokens,address NFTcontractAddress, uint tokenId) public payable   {
        Listing memory item = ListingDetails[NFTcontractAddress][tokenId];
        uint PricePerToken = ((item.price * item.amount) - (item.discount))/item.noOftokens;
        require(msg.value >= PricePerToken * _amountOfTokens,"Not enough ether sent");
        require(_safeTransferFrom(address(this),msg.sender,_counter,_amountOfTokens,""));
        uint AfterFEE= (msg.value * 995)/1000;
        (bool success,) = item.seller.call{value: AfterFEE}("");
        require(success, "Failed to send ether to seller");
    }

    function withdraw(uint _counter, address contractAddress,uint tokenId) public {
        Listing memory item = ListingDetails[contractAddress][tokenId];
        uint MAXCLAIMofNFT= NFTPurchasePrice[contractAddress][tokenId];
        uint PerTokenWIthdraw = MAXCLAIMofNFT/item.noOftokens;
        uint ETHamountToWithdraw= PerTokenWIthdraw * balanceOf(msg.sender,_counter);
        _burn(msg.sender,_counter,balanceOf(msg.sender,_counter));
        (bool success,) = msg.sender.call{value: ETHamountToWithdraw}("");
        require(success,"Failed to send Eth to you");
    }

}






