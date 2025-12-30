-include .env




deployOnSepolia :; forge script script/DeployV1.s.sol --rpc-url $(RPC_URL_SEPOLIA) --account $(sk_wallet) --broadcast --etherscan-api-key $(ETH_SEPOLIA_API) --verify
deployOnAnvil :; forge script script/DeployV1.s.sol --rpc-url $(anvil_rpc) --private-key $(anvil_key) --broadcast


deployOnSepoliaUpgradeToV2 :; forge script script/upgradeToV2.s.sol --rpc-url $(RPC_URL_SEPOLIA) --account $(sk_wallet) --broadcast --etherscan-api-key $(ETH_SEPOLIA_API) --verify
deployOnAnvilUpgradeToV2 :; forge script script/upgradeToV2.s.sol --rpc-url $(anvil_rpc) --private-key $(anvil_key) --broadcast