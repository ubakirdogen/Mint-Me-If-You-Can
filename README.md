# "Mint Me If You Can" - A NFT Project

## 1. Description

This is an NFT smart contract, where the NFT image data together with its metadata is stored on blockchain after minting. Image itself consists of squares, colors of which are chosen randomly during minting.
The first NFT token that is minted has only one square(1x1), the second token has four (2x2) and so on. The image is in SVG format and created from SVG tags, which are stored in Base64 encoded form on the block chain. The SVG code block that represents the NFT image gets bigger with the increasing number squares that it contains. This means, the gas fee(or network fee) increases with the token ID since NFT images with higher token IDs have more squares in it, so more SVG code. To sum up, the price for minting NFT from this contract gets more difficult(or more expensive) at every minting.
To see what these images look like, open **createRectangle.html** on a browser and enter the number of squares on each axis of the main square.

## 2. Deploy and Mint

### 2.1 Requirements

After cloning this repo: (node.js must be already installed)

```bash
$ npm install
```

### 2.2. Deploy

You can deploy this contract on any EVM-Compatible blockhain and on their testnets.(Ethereum, Polygon, Avalanche, BSC etc.)
After installing the dependencies, first compile and deploy the contract(for example on rinkeby testnet of ETH)

```bash
$ npx hardhat compile
$ npx hardhat run ./scripts/mintMeDeploy.js --network rinkeby
```

### 2.2. Mint

After contract deployment, the NFTs can be minted sequentially using the minNFT script:

```bash
$ npx hardhat run ./scripts/mintNFT.js --network rinkeby
```

You can display the minted NFT on an NFT marketplace, for example on OpenSea using the following link:
**ht<span>tps://</span>testnets.opensea.io/assets/-NFT Contract Address-/-Token ID-**
