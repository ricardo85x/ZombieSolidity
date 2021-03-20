pragma solidity >=0.5.0 <0.6.0;

import "./Ownable.sol";


contract ZombieFactory is Ownable{

    // evento
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; // 10 elevado a 16 (10,000,000,000,000,000)
    // exemplo
    // 10 * 10 = 100, 10 * 10 * 10 = 1.000, 10 * 10 * 10 * 10 = 10.000
    // logo este dnaModulus é 1 + 16 zeros = 10,000,000,000,000,000

    uint cooldownTime = 1 days;


    // objeto do tipo zombie
    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    // array de zombies
    Zombie[] public zombies;

    // key -> value 
    mapping (uint => address ) public zombieToOwner;
    mapping (address => uint ) ownerZombieCount;


    function _createZombie(string memory _name, uint dna) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
        // id = index do array do item adicionado

        // o dono do zombi é quem executou esta função
        zombieToOwner[id] = msg.sender;
        // incrementa o numero de zombies que o usuario tem;
        ownerZombieCount[msg.sender]++;
        // envia  um evento sempre que um zombie é criado
        emit NewZombie(id, _name, _dna);
    }

    // cria um dna (numero de 16 digitos) de acordo com o nome 
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // por padrão todo argumento da função é memory.
        // mas este exemplo gosta de ser redundante

        // o keccak256 é um gera um sha256, convertemos ele para numero
        // e abaixo pegamos apenas os 16 digitos dele.
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        
        // endereço só pode ser chamado 1x esta função
        require(ownerZombieCount[msg.sender] == 0);
        uint randDNa = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }


}


// contrato para tratar a alimentação
