// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./ContractVersions.sol";

contract Example_v0 is OwnableUpgradeable, UUPSUpgradeable, ContractVersions {
    uint256 private _param1;
    uint256 private _param2;

    function initialize(uint256 param1, uint256 param2)
        public
        virtual
        initializer
    {
        __Ownable_init_unchained();
        initialize_v0(param1, param2);
    }

    // simulating unversioned init, using OpenZeppelin `onlyInitializing` modifier
    function initialize_v0(uint256 param1, uint256 param2)
        public
        onlyInitializing
    {
        _param1 = param1;
        _param2 = param2;
    }

    // stub stuff 1
    function _getSum1() internal view returns (uint256) {
        return _param1 + _param2;
    }

    // example of a function using all parameters
    function getSum() external view virtual returns (uint256) {
        return _getSum1();
    }

    /**
     * @dev Authorize contract upgrade
     *
     * See {UUPSUpgradeable-_authorizeUpgrade}.
     */
    function _authorizeUpgrade(address newImplementation)
        internal
        virtual
        override(UUPSUpgradeable)
        onlyOwner
    {
        newImplementation;
        // super._authorizeUpgrade(newImplementation);
    }
}
