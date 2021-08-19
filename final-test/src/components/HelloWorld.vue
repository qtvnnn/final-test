<template>
  <v-container>
    <v-form ref="transForm" v-model="validForm">
      <v-row class="text-center">
        <v-col>
          <v-btn v-if="!account" @click="connectWallet">Connect wallet</v-btn>
          <div v-else>
            <p>Address: {{ account }}</p>
          </div>
        </v-col>
      </v-row>
      <v-row align="baseline">
        <v-col cols="12" md="2">
          <span>Address receiver:</span>
        </v-col>
        <v-col cols="12" md="10">
          <v-text-field
            v-model="addressReceiver"
            solo
            label="Recipient's wallet address"
            required
            :rules="addressRules"
            :counter="42"
            clearable
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row align="baseline">
        <v-col cols="12" md="2">
          <span>Amount:</span>
        </v-col>
        <v-col cols="12" md="10">
          <v-text-field
            v-model="amount"
            solo
            label="Amount to transfer"
            required
            :rules="amountRules"
            clearable
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row class="text-center">
        <v-col>Max amount: 999</v-col>
      </v-row>
      <v-row justify="center">
        <v-col cols="12" md="2">
          <v-btn color="teal" @click="approve" block>Approve</v-btn>
        </v-col>
        <v-col cols="12" md="2">
          <v-btn color="error" @click="transfer" :loading="loadingBtn" block
            >Transfer</v-btn
          >
        </v-col>
      </v-row>
      <v-row v-if="status">
        <v-col cols="12" md="3"> Successful transaction!! </v-col>
        <v-col cols="12" md="9">
          <span>Transaction: </span>
          <a
            :href="`https://testnet.bscscan.com/tx/${transHash}`"
            target="_blank"
            >{{ transHash }}</a
          >
        </v-col>
      </v-row>
    </v-form>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import getWeb3 from "../blockchain/getWeb3";
const { ethers } = require("ethers");
export default {
  name: "HelloWorld",
  props: {
    account: String,
  },
  data: () => ({
    validForm: true,
    addressReceiver: "",
    amount: "",
    status: false,
    loadingBtn: false,
    addressRules: [
      (v) => !!v || "Address is required",
      (v) => v.length == 42 || "Address must be 42 characters",
    ],
    amountRules: [(v) => !!v || "Amount is required"],
    transHash:
      "0x3596afb771a36070ac8c57cc982d837b1a168c800bd67c036663d7268151e8c2",
  }),
  computed: {
    ...mapGetters({ getContract: "getContract" }),
    ...mapGetters({ getContractBank: "getContractBank" }),
  },
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
    transfer() {
      if (this.$refs.transForm.validate()) {
        // const { ethers } = require("ethers");
        const BigNumber = ethers.BigNumber;
        this.loadingBtn = true;
        console.log(this.addressReceiver);
        this.getContractBank.methods
          .transferBank(
            this.addressReceiver,
            BigNumber.from("" + this.amount * 1000000000000000000)
          )
          .send({ from: this.account })
          .then((res) => {
            console.log("success", res.transactionHash);
            this.transHash = res.transactionHash;
          })
          .then(() => {
            this.status = true;
            this.loadingBtn = false;
          })
          .catch((err) => {
            console.log("fail", err);
          });
      }
    },
    approve() {
      const BigNumber2 = ethers.BigNumber;
      this.getContract.methods
        .approve(
          "0x45C61361c5602fd04Ad36a73193B9CAEcaA4C0E9",
          BigNumber2.from("" + 999 * 1000000000000000000)
        )
        .send({ from: this.account })
        .then((res) => {
          console.log("success", res.transactionHash);
        })
        .catch((err) => {
          console.log("fail", err);
        });
    },
  },
};
</script>
