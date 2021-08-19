import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    account: "",
  },
  getters: {
    getAccount: (state) => state.account,
  },
  mutations: {
    SET_ACCOUNT: (state, account) => {
      state.account = account;
    },
  },
  actions: {
    changeCurrentAddress({ commit }, address) {
      commit("SET_ACCOUNT", address);
    },
  },
});
