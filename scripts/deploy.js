// Hardhat Runtime Environment explicitly required for standalone execution
const hre = require("hardhat");

async function main() {
  const initBalance = 1; // Initial balance for the contract
  const Assessment = await hre.ethers.getContractFactory("Assessment");

  // Deploy the contract with the initial balance
  const assessment = await Assessment.deploy(initBalance);
  await assessment.deployed();

  console.log(`Contract deployed with an initial balance of ${initBalance} ETH`);
  console.log(`Deployed contract address: ${assessment.address}`);

  // Example of using the deployed contract to initialize values (optional)
  const tasks = [
    "Complete Solidity course",
    "Build a React DApp",
    "Deploy on Ethereum testnet",
  ];

  console.log("Adding initial tasks to the contract...");
  for (const task of tasks) {
    const tx = await assessment.addTask(task); // Ensure the contract has `addTask` functionality
    await tx.wait();
    console.log(`Added task: "${task}"`);
  }

  console.log("Contract deployment and initialization complete!");
}

// Proper async/await usage and error handling
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
