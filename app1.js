const abi  = '';
const ZombieFactoryContract = web3.eth.contract(abi);
const contractAddress = '';

// has access to our contract public functions and events
const ZombieFactory = ZombieFactoryContract.at(contractAddress);

$("#add_zombie").click(function(e) {
    const name = $("#nameInput").val()
    ZombieFactory.createRandomZombie(name);
})

const event = ZombieFactory.NewZombie((error, result) => {
    if (error) return;
    
})

const generateZombie = (id, name, dna) => {
    let dnaStr = String(dna);

    // coloca zero no inicio enquanto o
    // dna é menor que 16 caracteres
    while(dnaStr.length < 16)
        dnaStr = "0" + dnaStr;

    const ZombieDetails = {
        headChoice: dnaStr.substring(0, 2) % 7 + 1,
    // 2nd 2 digits make up the eyes, 11 variations:
        eyeChoice: dnaStr.substring(2, 4) % 11 + 1,
        // 6 variations of shirts:
        shirtChoice: dnaStr.substring(4, 6) % 6 + 1,
        // last 6 digits control color. Updated using CSS filter: hue-rotate
        // which has 360 degrees:
        skinColorChoice: parseInt(dnaStr.substring(6, 8) / 100 * 360),
        eyeColorChoice: parseInt(dnaStr.substring(8, 10) / 100 * 360),
        clothesColorChoice: parseInt(dnaStr.substring(10, 12) / 100 * 360),
        zombieName: name,
        zombieDescription: "A Level 1 CryptoZombie",
    }

    return ZombieDetails;
    
}