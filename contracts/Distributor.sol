//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IDividends {
    function transfer(address to, uint256 amount) external;
    
    function balanceOf(address account) external view returns (uint256);
    
    function withdraw() external;
    
    function checkDividendsBalance() external view returns (uint256);
    
    function getHoldersNumber() external view returns(uint256);
    
    function getContributorByIndex(uint256 _index) external view returns(address);
    
    function totalSupply() external view returns(uint256);
}

contract Distributor {

    uint256 currentBalance = address(this).balance;

    address Dividends = 0x097361C821B6EDaACA0D3d99a0F52d284051c75a;

    IDividends distributor = IDividends(Dividends);

    function payout() external payable {
         for(uint i = 0; i < distributor.getHoldersNumber(); i++) {
            address balance = distributor.getContributorByIndex(i);
            uint256 payoutQuota = currentBalance / distributor.getHoldersNumber();
            distributor.transfer(balance, payoutQuota);
        }
    }
}