<template>
  <hello-world :account="account" />
</template>

<script>
import Web3 from "web3";
import { mapGetters } from "vuex";
import HelloWorld from "../components/HelloWorld";

export default {
  name: "Home",

  components: {
    HelloWorld,
  },
  computed: {
    ...mapGetters({ account: "getAccount" }),
  },
  mounted() {
    this.checkConnect();
  },
  methods: {
    checkConnect() {
      let web31;
      if (window.web3.currentProvider) {
        web31 = new Web3(window.web3.currentProvider);
        web31.eth.getAccounts().then((res) => {
          this.$store.commit("SET_ACCOUNT", res[0]);
        });
      }
    },
  },
};
</script>
