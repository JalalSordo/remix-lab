pragma solidity ^0.4.17; //version to be used of solidity

contract Lottrey{
    
     address public  manager ;
     address[] public players;
     
     function Lottery() public{
         manager=msg.sender;
     }
    
    function enter() public payable {
        require(msg.value>1 wei);
        players.push(msg.sender);
    }
    
    function getCurrentBalance() public view returns (uint){
        return address(this).balance ; 
    }
    
    function pickWinner() public onlyManagerCanCall{
        require(msg.sender==manager);
        uint index=random()%players.length;
        players[index].transfer(getCurrentBalance());
        players= new address[](0);   
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty,now,players));
    }
    
    modifier onlyManagerCanCall(){
	    require(msg.sender == manager);
	_;
}
}