// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StringExt.sol";

library SVGLib {

    function openTagSVG(uint256 width, uint256 height, uint256 precision) internal pure returns(bytes memory) {
        return abi.encodePacked('<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="', StringExt.toString(width, precision), '" height="', StringExt.toString(height, precision), '">');
    }    

    function rectTagSVG(uint256 xPos, uint256 yPos, uint256 rectWidth, uint256 rectHeight, uint256 precision, uint8[3] memory rgbVal) internal pure returns(bytes memory) {
        return abi.encodePacked('<rect x="',  StringExt.toString(xPos, precision), '" y="',  StringExt.toString(yPos, precision), '" width="',  StringExt.toString(rectWidth, precision), '" height="', StringExt.toString(rectHeight, precision), '" style="fill:rgb(', StringExt.toString(rgbVal[0]), ',', StringExt.toString(rgbVal[1]), ',', StringExt.toString(rgbVal[2]), ');stroke:black;stroke-width:1;opacity:0.8" />');
    }

    function textTagSVG(uint256 dim) internal pure returns(bytes memory) {
        return abi.encodePacked('<text fill="#FFFFFF" font-size="30" font-family="Verdana" x="50%" y="50%" dominant-baseline="middle" text-anchor="middle">', StringExt.toString(dim), 'x', StringExt.toString(dim), '</text>');
    }

    function closeTagSVG() internal pure returns(bytes memory) {
        return abi.encodePacked('</svg>');
    }  
		
    function generateRandomRGB(uint256 seed) internal view returns (uint8[3] memory) {
        bytes32 randNum = keccak256(abi.encodePacked(block.difficulty, block.number, block.timestamp, tx.origin, tx.gasprice, seed));
        return [uint8(randNum[0]), uint8(randNum[1]), uint8(randNum[2])];
    }
}

