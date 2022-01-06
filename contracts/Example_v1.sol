// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Example_v0.sol";

contract Example_v1 is Example_v0 {
    uint256 private _param3;
    uint256 private _param4;

    // define new `initialize` in case of deploy from scratch
    function initialize(
        uint256 param1,
        uint256 param2,
        uint256 param3,
        uint256 param4
    ) public virtual initializer {
        __Ownable_init_unchained();
        initialize_v0(param1, param2);
        initialize_v1(param3, param4);
    }

    // all the magic inside updateContractVersion(1) modifier
    function initialize_v1(uint256 param3, uint256 param4)
        public
        updateContractVersion(1)
    {
        _param3 = param3;
        _param4 = param4;
    }

    // stub stuff 2
    function _getSum2() internal view returns (uint256) {
        return _param3 + _param4;
    }

    // example of a overriding function using all parameters
    function getSum() external view virtual override returns (uint256) {
        return _getSum1() + _getSum2();
    }
}
