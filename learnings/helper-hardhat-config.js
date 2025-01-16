const networkConfig= {
    11155111:{
        name:"sepolia",
        ethUsdPriceFeed:"0x694AA1769357215DE4FAC081bf1f309aDC325306",
        waitConfirmations:6

    },
    31337:{
        name:"localhost",
        waitConfirmations:0,

    }


}
const developmentNetworks = ["localhost","hardhat"]


module.exports={
    networkConfig,
    developmentNetworks
}