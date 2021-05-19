<template>
  <v-container class="pt-10">
    <List
      :items="items"
      @add-item="addItem"
      @change-done="changeDone"
      @change-undone="changeUnDone"
      @delete-item="deleteItem"
      @delete-done="deleteDone"
    />
  </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import Item from '@/models/Item'
import List from '@/components/List.vue'

// const apiurl: string = process.env.APIURL ? process.env.APIURL : 'localhost'
// if (process.env. )
// const port: string = !process.env.PORT ? process.env.PORT : '4000'
// const APIROOT: string = apiurl + ':' + port
const APIROOT: string = process.env.BASE_URL
  ? process.env.BASE_URL
  : 'localhost:4000'

export default Vue.extend({
  components: {
    List,
  },
  data: (): { items: Item[] } => ({
    items: [],
  }),
  async created() {
    await this.getItems()
  },
  methods: {
    async getItems() {
      const res = await this.$axios.get(APIROOT + '/items')
      this.items = res.data
    },
    async addItem(itemName: string) {
      await this.$axios.post(APIROOT + '/items', {
        name: itemName,
      })
      await this.getItems()
    },
    async changeDone(id: number) {
      await this.$axios.put(APIROOT + `/items/${id}/done`)
      await this.getItems()
    },
    async changeUnDone(id: number) {
      await this.$axios.delete(APIROOT + `/items/${id}/done`)
      await this.getItems()
    },
    async deleteItem(id: number) {
      await this.$axios.delete(APIROOT + `/items/${id}`)
      await this.getItems()
    },
    async deleteDone() {
      await this.$axios.delete(APIROOT + '/items')
      await this.getItems()
    },
  },
})
</script>
