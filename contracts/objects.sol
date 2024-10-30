// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Objects {
        uint public  PublicInt;
        string public PublicString;
    // a struct is used to define a structure of the onject ;
    struct  Object{
       string name;
       uint age;

    }
    // constructor similar to object oriented programming ;
    constructor(string memory user, uint rollno){
        PublicString=user;

        PublicInt=rollno;

    }
    //  mapping is a data type in solidity similar to dictioinary but this has complexity of 1 as it uses 
    // hashing to store key value pair similar to hash table 

    mapping(string => uint ) public mapNameToAge;
    // declaring an array of type object ;
    Object[] public arrayOfObjects;
    Object public obj1=  Object("rohit", 19);
    function inputObject(string memory _objname, uint  _objage ) public {
        arrayOfObjects.push(Object(_objname,_objage));
        mapNameToAge[_objname]= _objage;
        
    }

}