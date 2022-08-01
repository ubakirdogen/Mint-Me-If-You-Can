// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library StringExt {
  bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

  /**
   * @dev Converts a `uint256` to its ASCII `string` decimal representation.
   */
  function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT licence
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

    if (value == 0) {
      return "0";
    }
    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }
    bytes memory buffer = new bytes(digits);
    while (value != 0) {
      digits -= 1;
      buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
      value /= 10;
    }
    return string(buffer);
  }

  /**
   * @dev Converts a `uint256` to its ASCII `string` representation with decimal places.
   */
  function toString(uint256 value, uint256 decPos) internal pure returns (string memory) {
    // Extension of original "toString function" for represent decimal places

    if (value == 0) {
      return "0";
    }
    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }

    uint256 digitsWithDec = 0;
    if (decPos == 0) {
      digitsWithDec = digits;
    } else if (decPos < digits) {
      digitsWithDec = digits + 1;
    } else {
      digitsWithDec = decPos + 2;
    }
    bytes memory buffer = new bytes(digitsWithDec);
    uint256 pos = digitsWithDec;
    while (pos > 0) {
      pos--;
      if (pos == (digitsWithDec - decPos - 1) && decPos != 0) {
        buffer[pos] = ".";
      } else {
        buffer[pos] = bytes1(uint8(48 + uint256(value % 10)));
        value = value != 0 ? value /= 10 : 0;
      }
    }
    return string(buffer);
  }

  /**
   * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
   */
  function toHexString(uint256 value) internal pure returns (string memory) {
    if (value == 0) {
      return "0x00";
    }
    uint256 temp = value;
    uint256 length = 0;
    while (temp != 0) {
      length++;
      temp >>= 8;
    }
    return toHexString(value, length);
  }

  /**
   * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
   */
  function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
    bytes memory buffer = new bytes(2 * length + 2);
    buffer[0] = "0";
    buffer[1] = "x";
    for (uint256 i = 2 * length + 1; i > 1; --i) {
      buffer[i] = _HEX_SYMBOLS[value & 0xf];
      value >>= 4;
    }
    require(value == 0, "Strings: hex length insufficient");
    return string(buffer);
  }
}
