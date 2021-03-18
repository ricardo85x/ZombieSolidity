pragma solidity >= 0.5.0 < 0.6.0;

import "./ZombieFactory.sol";

// pegar um contrato externo 
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  // Inicialize o kittyContract aqui usando `ckAddress` acima
  KittyInterface kittyContract;

  modifier ownerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }

  function setKittyContractAddress(address _address) external {
    kittyContract = _address;
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
      _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) {
      return (_zombie.readyTime <= now); 
  }


  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal ownerOf(_zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];

    _targetDna = _targetDna % dnaModulus;
    require(_isReady(myZombie));
    uint newDna = (myZombie.dna + _targetDna) / 2;

    if(keccak256(_species) == keccak256("kitty")){
      // aqui trocamos os ultimos 2 digitos por 99
      newDna = newDna - newDna % 100 + 99;
    }

    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);


  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna; 
    // grava o dna que é o 10th item da funcao getKitty
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}
