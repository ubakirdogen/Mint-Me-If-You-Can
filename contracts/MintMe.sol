// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./SVGLib.sol";

contract MintMe is ERC721 {
  uint256 private constant SIDEDIM = 51200;
  uint256 private constant PRECISION = 2;

  uint256 public lastMintedTokenId;
  mapping(uint256 => string) public tokenId2SVG;

  constructor() ERC721("Mint me if you can", "MIYC") {}

  function mint() public {
    lastMintedTokenId++;
    _safeMint(_msgSender(), lastMintedTokenId);
    tokenId2SVG[lastMintedTokenId] = createMetaData(lastMintedTokenId);
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
    return tokenId2SVG[tokenId];
  }

  function createMetaData(uint256 seg) public view returns (string memory) {
    string memory openTag = string(SVGLib.openTagSVG(SIDEDIM, SIDEDIM, PRECISION));
    string memory rectSVGStr = openTag;
    uint256 rectSide = SIDEDIM / seg;

    for (uint256 i = 0; i < seg; i++) {
      for (uint256 j = 0; j < seg; j++) {
        uint8[3] memory rgbVal = SVGLib.generateRandomRGB(i * j + i + j);
        string memory rectTag = string(SVGLib.rectTagSVG(j * rectSide, i * rectSide, rectSide, rectSide, PRECISION, rgbVal));
        rectSVGStr = string(abi.encodePacked(rectSVGStr, rectTag));
      }
    }

    string memory textTag = string(SVGLib.textTagSVG(seg));
    string memory closeTag = string(SVGLib.closeTagSVG());
    rectSVGStr = string(abi.encodePacked(rectSVGStr, textTag, closeTag));
    string memory svgBase64 = Base64.encode(abi.encodePacked(rectSVGStr));
    string memory svgBase64withPrefix = string(abi.encodePacked("data:image/svg+xml;base64,", svgBase64));
    string memory jsonMainPartRaw = '{"name":"Mint Me", "description":"tbd", "image":"';
    string memory jsonBase64 = Base64.encode(abi.encodePacked(jsonMainPartRaw, svgBase64withPrefix, '"}'));
    string memory jsonAppBase64 = string(abi.encodePacked("data:application/json;base64,", jsonBase64));
    return jsonAppBase64;
  }
}
