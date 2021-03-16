var abi = '' /* abi gerada pelo compilador */
var ZombieFeedingContract = web3.eth.contract(abi)
var contractAddress = '' /* endereço do nosso contrato após implantado */
var ZombieFeeding = ZombieFeedingContract.at(contractAddress)

// Presumindo que temos nosso ID do zumbi e do ID do gatinho que queremos atacar
let zombieId = 1;
let kittyId = 1;

// Para obter a imagem do CryptoKitty, precisamos pesquisar na API deles.
// Esta informação não é guardada no blockchain, somente no servidor web.
// Se tudo fosse guardado na blockchain, não teríamos que se preocupar
// se o servidor cair, mudanças na API deles, ou mesmo se a empresa
// nos bloqueassem para carregarmos as imagens se caso não gostarem de jogos de zumbi ;)
let apiUrl = "https://api.cryptokitties.co/kitties/" + kittyId
$.get(apiUrl, function(data) {
  let imgUrl = data.image_url
  // faça algo para mostrar a imagem
})

// Quando o usuário clica no gatinho:
$(".kittyImage").click(function(e) {
  // Chama o método `feedOnKitty` do nosso contrato
  ZombieFeeding.feedOnKitty(zombieId, kittyId)
})

// Escuta por evento NewZombie em nosso contrato e então podemos mostrar:
ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  // Esta função irá mostrar um novo zumbi, como na lição 1:
    (result.zombieId, result.name, result.dna)
})