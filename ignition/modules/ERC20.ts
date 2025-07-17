import {buildModule} from '@nomicfoundation/hardhat-ignition/modules'

export default buildModule("ERC20Module", m => {
    const CERC20 = m.contract("CERC20", []);
    return {CERC20};
})