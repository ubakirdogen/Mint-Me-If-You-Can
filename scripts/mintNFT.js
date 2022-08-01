const hre = require("hardhat");

const MINT_ME_ADDRESS = "0x34DF08FfA63119133dD672FeeAD583f6b3FAf65F";

const mintNFT = async () => {
  const mintMe = await hre.ethers.getContractAt("MintMe", MINT_ME_ADDRESS);
  console.log(`Minting from contract at: ${mintMe.address}...`);
  tx = await mintMe.mint({ gasLimit: 29000000 });
  await tx.wait();
  console.log(`NFT with Token Id ${await mintMe.lastMintedTokenId()} is succesfully minted!`);
};

mintNFT().then();
