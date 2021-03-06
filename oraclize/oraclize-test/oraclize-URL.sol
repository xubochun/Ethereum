pragma solidity ^0.4.20;

import "https://github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract OraclizeTest is usingOraclize {

    address owner;
    string public ETHUSD;

    event LogInfo(string description);
    event LogPriceUpdate(string price);
    event LogUpdate(address indexed _owner, uint indexed _balance);

    // Constructor
    function OraclizeTest() payable public { 
        owner = msg.sender;
        LogUpdate(owner,address(this).balance);
    
        // Replace the next line with your version:
        OAR = OraclizeAddrResolverI(0xAef5DE6025aB286998224549C0f6e4aACF826A95);

        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
        update();
    }

    // Fallback function
    function() public{
        revert();
    }

    function __callback(bytes32 id, string result, bytes proof) public {
        require(msg.sender == oraclize_cbAddress());

        ETHUSD = result;
        LogPriceUpdate(ETHUSD);
        update();
    }

    function getBalance() public returns (uint _balance) {
        return address(this).balance;
    }

    function update() payable public {
        // Check if we have enough remaining funds
        if (oraclize_getPrice("URL") > address(this).balance) {
            LogInfo("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else { LogInfo("Oraclize query was sent, standing by for the answer..");

            // Using XPath to to fetch the right element in the JSON response
            oraclize_query("URL", "json(https://api.coinbase.com/v2/prices/ETH-USD/spot).data.amount");
        }
    }
}