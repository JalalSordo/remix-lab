
pragma solidity ^0.4.17;

contract Campaign{
    
    struct Request{
         string description;
         uint256 value;
         address recipient;
         bool complete;
         
     }
     
    //is the person who deployed the initiated the contract
   address public manager;
   
   //necessary to make sure you have diffrent treshhold of contribution base don the project
   uint256 public minimumContrbution ;
   
   //list of people who contributed to the project
   address[] public approvers ;
   
   //list of all requestes created in teh contract
   Request[] public requests ;
   
     
    constructor (uint256 minimum) public {
        minimumContrbution = minimum;
        manager = msg.sender;
    }
    // if uou want to access to mesage value you need to state it spayable which is the amoutn of ether sent in the trns
    function enter() public payable {
        require(msg.value > minimumContrbution);
        approvers.push(msg.sender);
    }
    
     function createRequest( string description, uint256 value, address recipient) public onlyManagerCanCall {
        Request memory request=Request({
            description:description,
            value:value,
            recipient:recipient,
            complete:false
        });
        requests.push(request);

    }
    
    function approveRequest() public onlyManagerCanCall {
        //TODO
    }
    
    function finalizeRequest( )  public onlyManagerCanCall {
        //TODO
    }
    
     modifier onlyManagerCanCall() {
        require(msg.sender == manager);
        _;
    }

}