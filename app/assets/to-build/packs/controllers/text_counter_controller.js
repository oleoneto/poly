import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["source", "output"]
    static classes = ["error"]
    static values = {
        limit: Number,
        wordMode: Boolean
    }

    connect() {
        this['sourceTarget'].addEventListener('input', this.sync.bind(this))
        this.sync()
    }

    sync(_) {
        this['outputTargets'].forEach(t => {
            let content = this["wordModeValue"] ? this["sourceTarget"].value.split(" ") : this["sourceTarget"].value
            t.textContent = `${content.length} ${this["wordModeValue"] ? "words" : "characters" }`

            if (content.length > this["limitValue"])
                t.classList.add(...this["errorClasses"])
            else
                t.classList.remove(...this["errorClasses"])
        })
    }
}
