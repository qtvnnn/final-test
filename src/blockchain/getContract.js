import MyToken from "./contract/MyToken.json";

export default (web3) => {
  return new web3.eth.Contract(
    MyToken.abi,
    "0x374Ab3dD33154E77fe3867590a547CA105D3f351"
  );
};
