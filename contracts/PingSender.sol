// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.8.17;

import "./polygonZKEVMContracts/interfaces/IBridgeMessageReceiver.sol";
import "./polygonZKEVMContracts/interfaces/IPolygonZkEVMBridge.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PingSender is Ownable{

   // Global Exit Root address
    IPolygonZkEVMBridge public immutable polygonZkEVMBridge;

    // Address in the other network that will receive the message
    address public pingReceiver;

    /**
     * @param _polygonZkEVMBridge Polygon zkevm bridge address
     */
    constructor(IPolygonZkEVMBridge _polygonZkEVMBridge) {
        polygonZkEVMBridge = _polygonZkEVMBridge;
    }

    /**
     * @dev Emitted when send a message to another network
     */
    event PingMessage(uint256 pingValue);

    /**
     * @dev Emitted when change the receiver
     */
    event SetReceiver(address newPingReceiver);

    /**
     * @notice Send a message to the other network
     * @param destinationNetwork Network destination
     * @param forceUpdateGlobalExitRoot Indicates if the global exit root is updated or not
     */
    function bridgePingMessage(
        uint32 destinationNetwork,
        bool forceUpdateGlobalExitRoot,
        uint256 pingValue
    ) public onlyOwner {
         bytes memory storeMessage = abi.encodeWithSignature("store(uint256)", pingValue);
        // Bridge ping message
        polygonZkEVMBridge.bridgeMessage(
            destinationNetwork,
            pingReceiver,
            forceUpdateGlobalExitRoot,
            storeMessage
        );

        emit PingMessage(pingValue);
    }

    /**
     * @notice Set the receiver of the message
     * @param newPingReceiver Address of the receiver in the other network
     */
    function setReceiver(address newPingReceiver) external onlyOwner {
        pingReceiver = newPingReceiver;
        emit SetReceiver(newPingReceiver);
    }
}
