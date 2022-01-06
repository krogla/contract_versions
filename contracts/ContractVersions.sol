// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/StorageSlotUpgradeable.sol";

contract ContractVersions {
    // This is the keccak-256 hash of "_CONTRACT_VERSION_POSITION_" subtracted by 1
    // bytes32 internal constant CONTRACT_VERSION_POSITION_SLOT = bytes32(uint256(keccak256("_CONTRACT_VERSION_POSITION_")) - 1);
    bytes32 internal constant CONTRACT_VERSION_POSITION_SLOT = 0x991b6a683c41c2b463852ea27ca37a7350f62cc0e1fa31153f53b2743c917a3e;

    event ContractVersion(uint256 version);

    // when used, the version value must be set explicitly
    modifier updateContractVersion(uint256 newVersion) {
        require(newVersion == _getVersion() + 1, "wrong base version");
        _;
        _setVersion(newVersion);
    }

    function contractVersion() public view returns (uint256) {
        return _getVersion();
    }

    function _getVersion() internal view returns (uint256) {
        return StorageSlotUpgradeable.getUint256Slot(CONTRACT_VERSION_POSITION_SLOT).value;
    }

    function _setVersion(uint256 newVersion) internal {
        StorageSlotUpgradeable.getUint256Slot(CONTRACT_VERSION_POSITION_SLOT).value = newVersion;
        emit ContractVersion(newVersion);
    }

    // Example usage
    // function initialize(uint256 param1, uint256 param2, uint256 param3, uint256 param4) public virtual initializer {
    //     // do stuff with param1 and param2
    //     initialize_v1();
    //     initialize_v2(param3, param4);
    // }

    // function initialize_v1() public updateContractVersion(1) {
    //     // do stuff
    // }

    // function initialize_v2(uint256 param3, uint256 param4) public virtual updateContractVersion(2) {
    //     // do stuff with param1 and param2
    // }
}
