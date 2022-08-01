const hre = require("hardhat");

async function deploy() {
  // Get the contract to deploy
  const MintMe = await hre.ethers.getContractFactory("MintMe");
  const mintMe = await MintMe.deploy();

  await mintMe.deployed();
  console.log("'Mint Me If You Can' deployed to:", mintMe.address);
}

deploy()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
