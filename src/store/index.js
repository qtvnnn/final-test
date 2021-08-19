import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    account: "",
    contract: {},
  },
  getters: {
    getAccount: (state) => state.account,
    getContract: (state) => state.contract,
  },
  mutations: {
    SET_ACCOUNT: (state, account) => {
      state.account = account;
    },
    SET_CONTRACT: (state, contract) => {
      state.contract = contract;
    },
  },
  actions: {
    changeCurrentAddress({ commit }, address) {
      commit("SET_ACCOUNT", address);
    },
  },
});
