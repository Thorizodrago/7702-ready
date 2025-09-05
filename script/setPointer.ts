import { ethers } from "ethers";
import * as dotenv from "dotenv";
dotenv.config();

// Deploy edilmiş Policy kontrat adresi
const POLICY_ADDRESS = "0xdD1ba6D3A90E1c8E5E56c087D0405C4f1e66c0f5";

// RPC ve private key
const RPC_URL = process.env.RPC_URL!;
const PRIVATE_KEY = process.env.PRIVATE_KEY!;

async function main() {
	const provider = new ethers.JsonRpcProvider(RPC_URL);
	const wallet = new ethers.Wallet(PRIVATE_KEY, provider);

	// Policy kontrat ABI
	const policyAbi = [
		"function owner() view returns (address)",
		"function exec(address target, uint256 value, bytes calldata data) external returns (bytes memory)",
		"function setOwner(address newOwner) external"
	];
	const policy = new ethers.Contract(POLICY_ADDRESS, policyAbi, wallet);

	console.log("Current owner:", await policy.owner());

	// Örnek: owner değiştir (opsiyonel demo)
	// const tx = await policy.setOwner(wallet.address);
	// await tx.wait();
	// console.log("New owner:", await policy.owner());

	console.log("EOA -> Policy pointer ready (demo complete).");
}

main().catch((err) => {
	console.error(err);
	process.exit(1);
});
