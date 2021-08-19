import Bank from "./contract/BankTest.json";

export default (web3) => {
  return new web3.eth.Contract(
    Bank.abi,
    "0xbc7395726374040B042C1708305EFD6BE7DA7278"
  );
};
