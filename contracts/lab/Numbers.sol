
pragma solidity ^0.4.17;

contract Numbers{
   
    int[] public numbers1;
    int[] public numbers2;
     
    function Numbers() public {
        numbers1.push(20);
        numbers1.push(32);
        changeArrayMemory(numbers1);
        
        numbers2.push(20);
        numbers2.push(32);
        changeArrayStorage(numbers2);
    }

    function changeArrayMemory (int [] memory array) private{
	    array[0]=1;
    }
    
    function changeArrayStorage (int [] storage array) private{
	    array[0]=1;
    }

}