pragma solidity >=0.5.0 <0.6.0;


contract ZombieFactory {

    // evento
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; // 10 elevado a 16
    // exemplo
    // 10 * 10 = 100, 10 * 10 * 10 = 1.000, 10 * 10 * 10 * 10 = 10.000
    // logo este dnaModulus é 1 + 16 zeros = 10,000,000,000,000,000

    // objeto do tipo zombie
    struct Zombie {
        string name;
        uint dna;
    }

    // array de zombies
    Zombie[] public zombies;

    mapping (uint => address ) public zombieToOwner;
    mapping (address => uint ) ownerZombieCount;


    function _createZombie(string memory _name, uint dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) -1;
        // envia  um evento sempre que um zombie é criado
        emit NewZombie(id, _name, _dna);
    }

    // cria um dna (numero de 16 digitos) de acordo com o nome 
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // o keccak256 é um gera um sha256, convertemos ele para numero
        // e abaixo pegamos apenas os 16 digitos dele.
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDNa = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}