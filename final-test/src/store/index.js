import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    account: "",
    contract: {},
    contractBank: {},
  },
  getters: {
    getAccount: (state) => state.account,
    getContract: (state) => state.contract,
    getContractBank: (state) => state.contractBank,
  },
  mutations: {
    SET_ACCOUNT: (state, account) => {
      state.account = account;
    },
    SET_CONTRACT: (state, contract) => {
      state.contract = contract;
    },
    SET_CONTRACT_BANK: (state, contractBank) => {
      state.contractBank = contractBank;
    },
  },
  actions: {
    changeCurrentAddress({ commit }, address) {
      commit("SET_ACCOUNT", address);
    },
  },
});
