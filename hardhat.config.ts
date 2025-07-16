import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
    solidity: "0.8.28",
    networks: {
        ganache: {
            url: "http://127.0.0.1:7545",
            chainId: 1337,

        }
    }
};

export default config;
