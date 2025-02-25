<template>
  <div class="search-results">
    <h2>Search Results for "{{ city }}" (Adults: {{ adults }})</h2>

    <div v-if="loading">Loading results...</div>
    <div v-else-if="error">Error: {{ error }}</div>

    <div v-else>
      <div v-if="listings.length === 0">No listings found.</div>

      <div class="listing" v-for="listing in listings" :key="listing.id">
        <h3>{{ listing.title }}</h3>
        <img
          v-if="listing.pictures && listing.pictures.length"
          :src="listing.pictures[0].thumbnail || listing.pictures[0].original"
          :alt="listing.title"
        />
      </div>
    </div>

    <router-link to="/">Back to Search</router-link>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';

const route = useRoute();
const city = route.query.city || '';
const adults = route.query.adults || 1;

const listings = ref([]);
const loading = ref(false);
const error = ref(null);

const fetchResults = async () => {
  loading.value = true;
  error.value = null;

  try {
    const { data } = await axios.get('/api/search', {
      params: { city, adults },
    });

    listings.value = data.listings || [];
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
};

onMounted(fetchResults);
</script>