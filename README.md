1. Upgrade Box -> BoxV2
2. Proxy    Box 
         -> BoxV2

There's 3 types of proxy implementations (Patrick explains them well):
1. Transparent (we're gonna be applying this one here)
2. UUPS
3. Diamond

We can:
1. Deploy a Proxy manually
2. We can deploy the proxy using hardhat-deploy's built-in proxies
3. Openzeppelin upgrades plugin

In this repo we're gonna do the 2.Deploying the proxy using hardhat-deploy's built in proxies
In patrick repo in scripts/otherUpgradeExamples, it will show how to use the 3. Openzeppelin upgrades plugin

Deploying a proxy manually its essentially how we've already did in the sublesson so it's straight forward, we won't do it now.

I haven't started this part in hardhat but I feel like proxies are something so important for the security that we might aswell do it manually from scratch, but I haven't seen what hardhat-deploy can do so let's see. 
Feel like its something we don't wanna use anything to speed the process and is actually so easy and nice to do manually, that you should always do manually but let's see. It's so easy.
Just build one contract with a fallback function with delegatecall inside pointing to a contract that we define with a storage variable through a set function only used by the owner, like we did in the examples in the sublesson inside the contracts folder.
