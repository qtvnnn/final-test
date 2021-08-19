import MyToken from "./contract/MyToken.json";

export default (web3) => {
  return new web3.eth.Contract(
    MyToken.abi,
    "0xE4fc553CC52A8c2F7DB8BD1F1Dc31Bc57E2e3cA4"
  );
};
