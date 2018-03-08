pragma solidity^0.4.0;
contract Bank{
    function totalSupply()public constant returns(uint256){}
    function transfer(address to,uint256 amount)public {}
    function balanceOf()public constant returns(uint256){}
    function mint(uint256 amount)public{}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint256) {}
     function transferFrom(address _from,address _to,uint256 _value) returns(bool success){}
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
     event Transfer(address indexed from, address indexed to, uint256 value);
}
contract Token is Bank{
    address owner;
    string public name;
    uint256 public decimals;
    string public symbol;
    uint256 public totalsupply;
    function Token(){
        owner=msg.sender;
        totalsupply=5000;
        balances[owner]=totalsupply;
        name="MNW";
        symbol="MNWS";
        decimals=18;
    }
    modifier check(uint256 amo){
        require(totalsupply>=amo);
        _;
    }
    mapping(address=> uint256)balances;
     mapping (address => mapping (address => uint256)) internal allowed;

    function totalSupply()public constant returns(uint256){
        return(totalsupply);
    }
    function balanceOf()public constant returns(uint256){
        return(balances[owner]);
    }
    function transfer(address to,uint256 amount)public check(amount){
        balances[owner]=balances[owner]-amount;
        balances[to]=balances[to]+amount;
    }
    function mint(uint256 amount)public check(amount){
        balances[owner]=balances[owner]+amount;
        require( balances[owner]<=totalsupply);
        }
         function transferFrom(address _from, address _to, uint256 _value) public check(_value) returns (bool success) {
    require(_to != address(0));
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][_to]);

    balances[_from] = balances[_from]-(_value);
    balances[_to] = balances[_to]+(_value);
    allowed[_from][_to] = allowed[_from][_to]-(_value);
    Transfer(_from, _to, _value);
    return true;
  }


  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

 
  function allowance(address _owner, address _spender)public constant returns (uint256) {
    return allowed[_owner][_spender];
  }

}
