import { Controller } from "@hotwired/stimulus"
import WaveSurfer from "wavesurfer.js"
import CursorPlugin from "wavesurfer.js/src/plugin/cursor"
import RegionsPlugin from "wavesurfer.js/src/plugin/regions"
import TimelinePlugin from "wavesurfer.js/src/plugin/timeline"
import numeral from "numeral"

// Defines a common interface for audio sources (cached and HTML element)
class WaveformAudio {
    constructor(id, url, title, elapsedTime = 0) {
        this.id = id
        this.url = url
        this.title = title
        this.elapsedTime = elapsedTime
        this.peaks = []
        this.element = document.createElement('audio')
        this.element.setAttribute('src', url)
        this.element.setAttribute('id', id)
        this.element.dataset.title = title
    }
    
    getElement() {
        return this.element
    }
}

export default class extends Controller {
    static targets = [
        "controls",
        "desktop",
        "download",
        "elapsedTime",
        "exportPCM",
        "link",
        "loading",
        "mobile",
        "next",
        "pause",
        "placeholder",
        "play",
        "playing",
        "previous",
        "speed",
        "totalTime",
        "waveform"
    ]

    static classes = [
        'playing',
        'paused',
        'loading'
    ]

    get sources() {
        return Array.from(document.querySelectorAll('audio'))
    }

    get audio() {
        if (this.loadFromCache && this.cachedAudio) {
            let { id, data, source } = JSON.parse(this.cachedAudio)
            let elapsedTime = parseFloat(localStorage.getItem('poly::player:time:elapsed')) || 0
            let element = new WaveformAudio(id, source, data.title, elapsedTime)

            let location = this.sources.findIndex(audio => audio.id === id)
            this.index = location > -1 ? location : this.index

            return element
        }

        let data = this.sources[this.index]
        let element = new WaveformAudio(data.id, data.src, data.dataset.title)

        // NOTE: Only cache data if source is <audio> element
        this.cacheAudioData(data)

        return element
    }

    initialize() {
        this.index = 0
        this.loadFromCache = true
        this.saveToCache = true
        this.rate = 0
        this.rates = [1, 1.25, 1.5, 1.75, 2, 0.5, 0.75]
        this.playbackRate = 1
    }

    connect() {
        // NOTE: Only create the waveform player on medium+ sized devices
        window.onresize = () => {
            if (window.innerWidth >= 768 && !this.wavesurfer) {
                this.setup()
            }
        }

        // NOTE: Do not create the waveform player if the element is set to hidden
        if (this['desktopTarget'].classList.contains('hidden') && window.innerWidth <= 768) {
            let element = this.audio.getElement()
            element.controls = true
            this['mobileTarget'].insertAdjacentElement('afterbegin', element)
            return
        }

        this.setup()
    }

    disconnect() {
        // NOTE: Stop listening for resize events
        window.onresize = () => {}
    }

    // ====================
    // Setup and Playback Methods
    // ====================
    setup() {
        this.wavesurfer = WaveSurfer.create({
            container: '#waveform',
            waveColor: 'violet',
            progressColor: 'purple',
            barWidth: 3,
            barRadius: 3,
            cursorWidth: 1,
            cursorColor: 'blue',
            height: 180,
            barGap: 3,
            hideScrollbar: true,
            responsive: true,
            partialRender: true,
            plugins: [
                CursorPlugin.create({
                    color: 'violet',
                    style: 'dashed',
                    showTime: true
                }),
                RegionsPlugin.create({
                    dragSelection: true,
                    loop: true
                }),
                TimelinePlugin.create({
                    container: '#timeline',
                    primaryLabelInterval: 3,
                    primaryFontColor: 'violet',
                    secondaryFontColor: 'violet',
                    fontSize: 11
                }),
            ]
        })

        this.loadFromCache = (this.element.dataset.loadCache === 'true')
        this.saveToCache = (this.element.dataset.saveCache === 'true')

        this.playbackRate = parseFloat(localStorage.getItem('poly::player:rate')) || this.playbackRate

        this.setPlaybackRate()

        this.handleVectorGraphics()

        this.handlePreviousAndNext()

        this.load()
    }

    load() {
        this.fetchPeaks(this.audio.id, (data) => {
            console.log('Loaded audio metada')

            this['linkTarget'].setAttribute('href', this.audio.url)

            this.wavesurfer.load(this.audio.url, data.peaks.data, 'auto')

            this.wavesurfer.on('loading', () => {
                // Hide audio controls. Show loading indicator.
                this['controlsTarget'].classList.toggle('hidden', true)
                this['loadingTarget'].classList.toggle('hidden', false)
                this['playingTarget'].innerText = `Loading... ${this.audio.title}`

                // Display `play` icon. Hide `pause` icon.
                this['playTarget'].classList.toggle('hidden', false)
                this['pauseTarget'].classList.toggle('hidden', true)

                // Disable buttons that require the data to be fully loaded
                this['exportPCMTarget'].setAttribute('disabled', true)
                this['downloadTarget'].setAttribute('disabled', true)
            })

            this.wavesurfer.on('ready', () => {
                this['controlsTarget'].classList.toggle('hidden', false)
                this['loadingTarget'].classList.toggle('hidden', true)
                this['playingTarget'].innerText = this.audio.title
                this['exportPCMTarget'].removeAttribute('disabled')
                this['downloadTarget'].removeAttribute('disabled')

                if (this.audio.elapsedTime > 0) {
                    this.wavesurfer.setCurrentTime(this.audio.elapsedTime)
                }

                this.updateTotalTime()
                this.updateElapsedTime()
            })

            this.wavesurfer.on('finish', () => {
                // Display `pause` icon. Hide `play` icon.
                this.togglePlaybackButtons()

                this.invalidateCachedAudioData()
            })

            this.wavesurfer.on('audioprocess', () => this.updateElapsedTime())
            this.wavesurfer.on('seek', () => this.updateElapsedTime())

            // NOTE: This hack circunvents an issue where the waveform would be
            // drawn but the 'ready' event would not fire.
            this.wavesurfer.fireEvent('interaction')
        })
    }

    tick() {
        return (this.index >= this.sources.length - 1) ? 0 : this.index++
    }

    untick() {
        if (this.index <= 0) {
            return this.index = this.sources.length - 1;
        }

        return this.index--
    }

    next() {
        this.loadFromCache = false
        this.tick()
        this.load()
    }

    previous() {
        this.loadFromCache = false
        this.untick()
        this.load()
    }

    toggle() {
        this.wavesurfer.playPause()
        this.togglePlaybackButtons()
    }

    changePlaybackRate() {
        this.rate = (this.rate + 1) % this.rates.length
        this.playbackRate = this.rates[this.rate]
        this.setPlaybackRate()
    }

    setPlaybackRate() {
        localStorage.setItem('poly::player:rate', this.playbackRate)
        this['speedTarget'].innerText = `${this.playbackRate}x`
        this.wavesurfer.setPlaybackRate(this.playbackRate)
    }

    togglePlaybackButtons() {
        this['playTarget'].classList.toggle('hidden')
        this['pauseTarget'].classList.toggle('hidden')
    }

    // ====================
    // Metadata Methods
    // ====================

    exportPCM() {
        this.wavesurfer.exportPCM()
    }

    fetchPeaks(id, callback) {
        fetch(`/metadata/${id}?type=episode`)
            .then(data => data.json())
            .then(data => callback(data))
            .catch(error => callback([]))
    }

    updateElapsedTime() {
        this['elapsedTimeTarget'].innerText = numeral(this.wavesurfer.getCurrentTime()).format("00:00:00")
        localStorage.setItem('poly::player:time:elapsed', this.wavesurfer.getCurrentTime())
    }

    updateTotalTime() {
        this['totalTimeTarget'].innerText = numeral(this.wavesurfer.getDuration()).format("00:00:00")
    }

    // ====================
    // Caching and Storage
    // ====================

    get cachedAudio() {
        return localStorage.getItem('poly::player:now:playing')
    }

    cacheAudioData(element) {
        if (!this.saveToCache) return;

        localStorage.setItem('poly::player:now:playing', JSON.stringify({
            data: element.dataset, source: element.src, id: element.id
        }))
    }

    invalidateCachedAudioData() {
        localStorage.removeItem('poly::player:now:playing')
    }
    
    // ====================
    // Helpers
    // ====================
    handleVectorGraphics() {
        // This is a hack to add `viewBox` attributes to SVGs on the page
        document.querySelectorAll('svg').forEach((element) => {
            if (!element.attributes.viewBox) {
                element.setAttribute('viewBox', '0 0 24 24')
            }
        })
    }
    
    // ====================
    // Helpers
    // ====================
    handleVectorGraphics() {
        // This is a hack to add `viewBox` attributes to SVGs on the page
        document.querySelectorAll('svg').forEach((element) => {
            if (!element.attributes.viewBox) {
                element.setAttribute('viewBox', '0 0 24 24')
            }
        })
    }

    handlePreviousAndNext() {
        if (this.sources.length === 1) {
            this['nextTarget'].classList.toggle('hidden', true)
            this['previousTarget'].classList.toggle('hidden', true)
        }
    }
}
