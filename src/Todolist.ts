import {createPublicClient, http, getContract, createWalletClient } from 'viem';
import {privateKeyToAccount} from 'viem/accounts'
import type {Chain} from 'viem'
import abi from './abi'

const CONTRACT_ADDRESS="0xa3C21FC7650359A026fF0a17928DAA4639c3446c"

const ganacheChain: Chain = {
    id: 1337,
    name: "ganache",
    nativeCurrency: {
        name: "Ether",
        symbol: "ETH",
        decimals: 18
    },
    rpcUrls: {
        default: {
            http: ['http://127.0.0.1:7545']
        }
    }
}

const client = createPublicClient({
    chain: ganacheChain,
    transport: http(ganacheChain.rpcUrls.default.http[0])
})

const contract = getContract({
    address:CONTRACT_ADDRESS,
    abi,
    client,

})

const walletClient = createWalletClient({
  chain: ganacheChain,
  transport: http(ganacheChain.rpcUrls.default.http[0]),
  account: privateKeyToAccount('0xa0e6596d0ea7c0cb46b2e621a837d06ed9b9999b7d15cf969eb7207528ccc174'),
})

async function main() {
    const txHash = await walletClient.writeContract({
        address: CONTRACT_ADDRESS,
        abi,
        functionName: 'createTask',
        args: ["创建任务"]
    })
    console.log('Transaction hash:', txHash)
}

main().then(() => {
    process.exit(0)
}).catch((error) => {
    console.error(error);
    process.exit(1);
})