import Bank from "./contract/BankTest.json";

export default (web3) => {
  return new web3.eth.Contract(
    Bank.abi,
    "0xa51Ab87868ee94aA19B1D7a1fA6DFed8C0523DD5"
  );
};
