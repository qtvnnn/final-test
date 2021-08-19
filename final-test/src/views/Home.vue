<template>
  <hello-world :account="account" />
</template>

<script>
import Web3 from "web3";
import { mapGetters } from "vuex";
import getContract from "../blockchain/getContract";
import getContractBank from "../blockchain/getContractBank";
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
      let web3;
      if (window.web3.currentProvider) {
        web3 = new Web3(window.web3.currentProvider);
        web3.eth.getAccounts().then((res) => {
          this.$store.commit("SET_ACCOUNT", res[0]);
        });

        const contract = getContract(web3);
        this.$store.commit("SET_CONTRACT", contract);
        console.log("0", contract.methods);

        const contractBank = getContractBank(web3);
        this.$store.commit("SET_CONTRACT_BANK", contractBank);
        console.log("1", contractBank.methods);
      }
    },
  },
};
</script>
