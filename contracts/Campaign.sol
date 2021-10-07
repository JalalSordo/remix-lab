
pragma solidity ^0.4.17;

contract Campaign{
    
    struct Request{
         string description;
         uint amount;
         address recipient;
         bool complete;
         mapping(address=>bool) approvals;
         uint approvalCount;
         
     }
     
    //is the person who deployed the initiated the contract
   address public manager;
   
   //necessary to make sure you have diffrent treshhold of contribution base don the project
   uint public minimumContrbution ;
   
   //list of people who contributed to the project
   mapping(address=>bool) public approvers;
   
   //list of all requestes created in the contract
   Request[] public requests ;
   
     
    constructor (uint minimum) public {
        minimumContrbution = minimum;
        manager = msg.sender;
    }
    
    // if uou want to access to mesage value you need to state it spayable which is the amoutn of ether sent in the trns
    function contribute() public payable {
        require(msg.value > minimumContrbution);
        approvers[msg.sender]=true;
    }
    
     function createRequest( string description, uint amount, address recipient) public onlyManagerCanCall {
         //custom loacl variables must explicily get decalred as in memory and not storage, case of struct
        Request memory request=Request({
            description:description,
            amount:amount,
            recipient:recipient,
            complete:false,
            approvalCount:0
        });
        requests.push(request);

    }
    
    function approveRequest(uint requestIndex) public  {
        //first check if this person has the right to vote, must be in the map of approvers (people who contributed)
        require(approvers[msg.sender]);
        
        //check if this person haven't voted before
        require(!requests[requestIndex].approvals[msg.sender]);
        
        //add a person to approvers
        requests[requestIndex].approvals[msg.sender]=true;
        
        //increment teh approval count of teh request
        requests[requestIndex].approvalCount++;
        
    }
    
    function finalizeRequest( )  public view onlyManagerCanCall {
        //TODO
    }
    
     modifier onlyManagerCanCall() {
        require(msg.sender == manager);
        _;
    }

}