import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import dotenv from 'dotenv'

dotenv.config()

const config: HardhatUserConfig = {
    solidity: "0.8.28",
    networks: {
        ganache: {
            url: "http://127.0.0.1:7545",
            chainId: 1337,
        },
        sepolia: {
            url: `https://sepolia.infura.io/v3/${process.env.INFURA_ID}`,
            accounts: [`0x${process.env.PRIVATE_KEY}`]
        }
    }
};

export default config;
