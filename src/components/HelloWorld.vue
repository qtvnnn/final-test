<template>
  <v-container>
    <v-row class="text-center">
      <v-col>
        <v-btn v-if="!account" @click="connectWallet">Connect wallet</v-btn>
        <div v-else>
          <p>Address: {{ account }}</p>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import getWeb3 from "../blockchain/getWeb3";
export default {
  name: "HelloWorld",
  props: {
    account: String,
  },
  data: () => ({}),
  methods: {
    connectWallet() {
      if (window.ethereum) {
        getWeb3().then((result) => {
          result.eth.getAccounts().then((res) => {
            console.log(res[0]);
            this.$store.commit("SET_ACCOUNT", res[0]);
          });
        });
      }
    },
  },
};
</script>
