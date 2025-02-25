<template>
  <div class="search-widget">
    <form @submit.prevent="submitSearch">
      <div>
        <label>City/Location:</label>
        <input
          v-model="city"
          list="cities"
          placeholder="Select or type city"
          required
        />
        <datalist id="cities">
          <option v-for="cityName in cities" :key="cityName" :value="cityName" />
        </datalist>
      </div>

      <div class="adults-input">
        <label>Number of Adults:</label>
        <div class="counter">
          <button type="button" @click="incrementAdults">+</button>
          <input
            type="number"
            v-model.number="adults"
            min="1"
            @input="validateAdults"
          />
          <button type="button" @click="decrementAdults">-</button>
        </div>
      </div>

      <button type="submit">Search</button>
    </form> 
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const city = ref('');
const adults = ref(1);
const cities = ref([]);
const router = useRouter();

const fetchCities = async () => {
  try {
    const { data } = await axios.get('/api/cities');
    cities.value = data.cities || [];
  } catch (error) {
    console.error('Error fetching cities:', error);
  }
};

const incrementAdults = () => { adults.value++; };
const decrementAdults = () => { if (adults.value > 1) adults.value--; };
const validateAdults = () => {
  if (adults.value < 1) adults.value = 1;
  if (adults.value > 10) adults.value = 10;
};

const submitSearch = () => {
  router.push({
    name: 'results',
    query: { city: city.value, adults: adults.value }
  });
};

onMounted(fetchCities);
</script>
