pragma solidity ^ 0.4 .0;

contract NewAccountContract {

    address private owner;

    struct Account {
        string username;
        string password;
        string fullname;
        string phone;
        string email;
    }

    mapping(string => Account) accounts;

    event ContractStatus(string id, string message);

    function NewAccountContract() public payable {
        owner = msg.sender;
    }


    function getAccountBy(string _address) public view
    returns(string username, string password, string fullname, string phone, string email) {
        username = accounts[_address].username;
        password = accounts[_address].password;
        fullname = accounts[_address].fullname;
        phone = accounts[_address].phone;
        email = accounts[_address].email;

        return;
    }

    function getPasswordBy(string _address) public view returns(string) {

        return accounts[_address].password;
    }

    function deposit() public payable returns(string errorcode) {
        if (msg.sender != owner) {
            ContractStatus("DEPOSIT", "not owner");
            errorcode = "NOT_OWNER";
            return;
        } else {
            ContractStatus("DEPOSIT", "success");
            errorcode = "SUCCESS";
            return;
        }
    }

    function newAccount(address _address, string _username, string _password, string _fullname, string _phone, string _email) public payable {

        if (msg.sender != owner) {
            ContractStatus("CREATE", "NOT_OWNER");
        } else {
            if (address(this).balance >= 1 ether) {
                
                if( keccak256(accounts[_username].username) == keccak256("")) {
                // accounts[_address] = Account(_username, password, fulname, phone, email);

                    // accounts[_username].username = _username;
                    // accounts[_username].password = _password;
                    // accounts[_username].fullname = _fullname;
                    // accounts[_username].phone = _phone;
                    // accounts[_username].email = _email;
                    
                    // transfer 1 ether to new account
                    _address.transfer(1 ether);
    
                    ContractStatus("CREATE", "SUCCESS");
                } else {
                    ContractStatus("CREATE_ALREADY_EXIST", "");
                }
            } else {
                ContractStatus("CREATE", "INSUFFICIENT_AMOUNT");
            }
        }
    }

}
