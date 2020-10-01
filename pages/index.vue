<template>
  <v-container class="pt-10">
    <List
      :items="items"
      @add-item="addItem"
      @change-done="changeDone"
      @delete-item="deleteItem"
      @delete-done="deleteDone"
    />
  </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import Item from '@/models/Item'
import List from '@/components/List.vue'

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
      const res = await this.$axios.get('http://localhost:4000/items/')
      this.items = res.data
    },
    async addItem(itemName: string) {
      await this.$axios.post(`http://localhost:4000/items/`, {
        name: itemName,
      })
      await this.getItems()
    },
    async changeDone(id: number) {
      await this.$axios.put(`http://localhost:4000/items/done/${id}/`)
    },
    async deleteItem(id: number) {
      await this.$axios.delete(`http://localhost:4000/items/${id}/`)
      await this.getItems()
    },
    async deleteDone() {
      await this.$axios.delete(`http://localhost:4000/items/`)
      await this.getItems()
    },
  },
})
</script>
