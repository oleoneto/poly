import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = []

    initialize() {
    }

    connect() {
        let loadFromCache = (this.element.dataset.loadCache === 'true')
        let saveToCache = (this.element.dataset.saveCache === 'true')

        if (this.audios.length >= 1) {
            console.log(this.audios.length);
            this.element.insertAdjacentHTML('afterbegin', this.template)
        }

        console.log('Audio scanner...');
    }

    get audios() {
        return document.querySelectorAll('audio')
    }

    get template() {
        return `
    <div data-controller="waveform" data-load-cache="${this.loadFromCache}" data-save-cache="${this.saveToCache}" id="interactive-player" class="py-4 relative border-b border-tertiary text-primary w-full">
    
      <div id="mobile-player" data-waveform-target="mobile" class="md:hidden w-full"></div>

      <div id="desktop-player" data-waveform-target="desktop" class="hidden md:block relative w-full">
        <div id="waveform" data-waveform-target="waveform"></div>
        <div id="timeline" data-waveform-target="timeline"></div>

        <div class="flex items-center justify-between py-2">
          <div data-waveform-target="loading">
            <svg class="w-7 h-7 animate-spin" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
          </div>
        
          <div data-waveform-target="controls" class="flex justify-between hidden">
            <button data-waveform-target="previous" data-action="click->waveform#previous">
              <svg class="w-8 h-8" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path d="M8.445 14.832A1 1 0 0010 14v-2.798l5.445 3.63A1 1 0 0017 14V6a1 1 0 00-1.555-.832L10 8.798V6a1 1 0 00-1.555-.832l-6 4a1 1 0 000 1.664l6 4z" />
              </svg>
            </button>
        
            <button data-action="click->waveform#toggle">
              <svg class="w-10 h-10" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path class="" data-waveform-target="play" fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM9.555 7.168A1 1 0 008 8v4a1 1 0 001.555.832l3-2a1 1 0 000-1.664l-3-2z" clip-rule="evenodd" />
                <path class="hidden" data-waveform-target="pause" fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zM7 8a1 1 0 012 0v4a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v4a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
              </svg>
            </button>
        
            <button data-waveform-target="next" data-action="click->waveform#next">
              <svg class="w-8 h-8" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path d="M4.555 5.168A1 1 0 003 6v8a1 1 0 001.555.832L10 11.202V14a1 1 0 001.555.832l6-4a1 1 0 000-1.664l-6-4A1 1 0 0010 6v2.798l-5.445-3.63z" />
              </svg>
            </button>
          </div>
        
          <!-- actions-start -->
          <div id="actions" class="flex items-center space-x-2">
            <p id="track-title" data-waveform-target="playing" class="text-xs font-light hidden md:block"></p>
        
            <button data-waveform-target="speed" data-action="click->waveform#changePlaybackRate" class="bg-gray-700 text-white text-xs font-black p-1.5 rounded">x</button>
        
            <button disabled data-waveform-target="exportPCM" data-action="click->waveform#exportPCM" class="hidden md:block bg-gray-700 text-white text-xs font-black p-1.5 rounded disabled:opacity-50">
              <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0 3.517-1.009 6.799-2.753 9.571m-3.44-2.04l.054-.09A13.916 13.916 0 008 11a4 4 0 118 0c0 1.017-.07 2.019-.203 3m-2.118 6.844A21.88 21.88 0 0015.171 17m3.839 1.132c.645-2.266.99-4.659.99-7.132A8 8 0 008 4.07M3 15.364c.64-1.319 1-2.8 1-4.364 0-1.457.39-2.823 1.07-4" />
              </svg>
            </button>
        
            <button data-waveform-target="download" class="hidden md:block bg-gray-700 text-white text-xs font-black p-1.5 rounded disabled:opacity-50">
              <a data-waveform-target="link" href="#">
                <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10" />
                </svg>
              </a>
            </button>
        
            <div id="duration" class="flex items-center justify-between space-x-1 text-white bg-indigo-600 rounded py-2 px-2 md:px-1 md:py-0.5 md:w-36">
              <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
        
              <div id="time" class="flex items-center md:space-x-1">
                <p data-waveform-target="elapsedTime" class="text-xs font-normal">0:00:00</p>
                <span class="hidden md:block">-</span>
                <p data-waveform-target="totalTime" class="hidden md:block text-xs font-normal">0:00:00</p>
              </div>
            </div>
          </div>
          <!-- actions-end -->
          </div>
        </div>
      </div>
    `
    }
}
