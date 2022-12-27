// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

//imported i=one of the most secure and inheritable and usable contracts
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';  

//allows us to define functions that only owner can use
import '@openzeppelin/contracts/access/Ownable.sol';       

//this signifies that our contract is inherited from the mentioned contracts and gonna provide some basic functionalities
contract RoboPunksNFT is ERC721, Ownable {
     uint256 public mintPrice;     //price of mint

     uint256 public totalSupply;   //total mints supplied

     uint256 public maxSupply;     //maximum mints that can be supplied

     uint256 public maxPerWallet;  //maximum mints each wallet can handle

     bool public isPublicMintEnabled;   // will determine when users can mint   

     string internal baseTokenUri;      // will determine where our images/data is located

     address payable public withdrawWallet;

     mapping(address => uint256) public walletMints;  //will determine and keep track of all mints that will be done






// Now here ERC721 takes two arguments i.e name and symbol
     constructor() payable ERC721 ('RoboPunks','RP'){ 
        mintPrice = 0.02 ether;
        totalSupply = 0;
        maxSupply = 1000;
        maxPerWallet = 3;
        //set withdraw wallet address
     }


//we add '_' so as to specify it as an argument and not to be confused as an parameter in our smart contract above
function setIsPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner{
    isPublicMintEnabled = isPublicMintEnabled_;
}



//now our basetokenUri consists or url that consists of URL
function setBaseUri(string calldata baseTokenUri_) external onlyOwner{
    baseTokenUri = baseTokenUri_;
}



// this function is called by opensea so as to grab the images and it's a default function existing in ERC721 , thus we've to override this function to make sure we're calling correct variables
function tokenURI(uint256 tokenId_)  public  view  override   returns(string memory) {

        require(_exists(tokenId_),'token does not exists');
        return string(abi.encodePacked(baseTokenUri,Strings.toString(tokenId_),'.json')); //we're taking the url that we identified , we're grabbing the Id and placing it behin th Url and attaching '.json' to it..

}

function withdraw() external onlyOwner{
    (bool success, ) = withdrawWallet.call{value: address(this).balance }('');//we're grabbing the wallet , we're calling it which is a low-level function , we're passing the address of contract in the balance and we're passing in empty.....
//thus it enables us to withdraw funds from the address mentioned above



    require(success,'withdraw failed');//it'll keep on going if it's success and if it is not then it'll display the message
}

// payable - requires a value transfer of ether

function mint(uint256 quantity_) public payable {
    require(isPublicMintEnabled,'minting not enabled');
    require(msg.value == quantity_ * mintPrice , 'wrong mint price'); // to check if value entered is correct or not
    require(totalSupply + quantity_ <= maxSupply , 'sold out');
    require(walletMints[msg.sender] * quantity_ <= maxPerWallet ,'max limit of wallet exceeded');

    for(uint256 i = 0 ; i <=quantity_ ; i++){
        uint256 newTokenId = totalSupply + 1;


        totalSupply++; //called check effects interaction pattern because we're incrementing the quantity before calling the function


        _safeMint(msg.sender , newTokenId); //built-in function used ,, address to recieve the NFT = msg.sender
    }
}


}