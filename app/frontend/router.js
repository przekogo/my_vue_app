import { createRouter, createWebHistory } from 'vue-router';
import SearchWidget from './components/SearchWidget.vue';
import SearchResults from './components/SearchResults.vue';

const routes = [

  { path: '/', component: SearchWidget, name: 'search' },
  { path: '/results', component: SearchResults, name: 'results' },
];

export default createRouter({
  history: createWebHistory(),
  routes,
});

