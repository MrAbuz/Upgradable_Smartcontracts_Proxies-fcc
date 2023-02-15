// Script to upgrade the implementation contract from boxv1 to boxv2
// We're gonna do it the manual way here and the reason we're gonna do the manual way is cuz he wants to show us the exact functions that we're calling to do this upgrade process
// However hardhat deploy also comes with an API to make it really easy to just upgrade our box contracts

const { ethers } = require("hardhat")

async function main() {
    const BoxProxyAdmin = await ethers.getContract("BoxProxyAdmin") // admin contract that we use instead of the admin address
    const transparentProxy = await ethers.getContract("Box_Proxy") // because when we deploy our "box" contract with the proxy feature in hardhat deploy, it deploys two contracts: Box_Implementation and Box_Proxy

    const proxyBoxV1 = await ethers.getContractAt("Box", transparentProxy.address)
    const versionV1 = await proxyBoxV1.version()
    console.log(versionV1.toString())

    const boxV2 = await ethers.getContract("BoxV2") // new contract that we want to upgrade to
    const upgradeTx = await BoxProxyAdmin.upgrade(transparentProxy.address, boxV2.address) // we call the upgrade() in the admin contract which will call the proxy which will change the implementation from box1 to box2
    await upgradeTx.wait(1)

    // And now to work with the functions on our Box v2
    // We want the BoxV2 ABI, but we want to call the transparentProxy address (which will delegate the call to the boxv2 contract). Makes total sense
    const proxyBoxV2 = await ethers.getContractAt("BoxV2", transparentProxy.address)
    const versionV2 = await proxyBoxV2.version()
    console.log(versionV2.toString())
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
