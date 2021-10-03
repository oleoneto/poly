/* eslint no-console: 0 */
import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbo:load', () => {
  const app = new Vue({
    el: '#vue',
    props: ["message"],
    data: () => {
      return {}
    },
    components: { App }
  })
})
