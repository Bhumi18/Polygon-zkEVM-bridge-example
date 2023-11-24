/* eslint-disable import/no-dynamic-require, no-await-in-loop, no-restricted-syntax, guard-for-in */
const path = require("path");
const hre = require("hardhat");

const testnetBridgeAddress = "0xF6BEEeBB578e214CA9E23B0e9683454Ff88Ed2A7";

async function main() {
  let zkEVMBridgeContractAddress = testnetBridgeAddress;

  try {
    // verify governance
    await hre.run("verify", {
      address: "0xE4F8c74291277d7557e7dFE292b26eA05371d3e2",
      constructorArguments: [zkEVMBridgeContractAddress],
    });
  } catch (error) {
    // expect(
    //   error.message.toLowerCase().includes("already verified")
    // ).to.be.equal(true);
    console.log(error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
