import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["source", "output"]

    connect() {
        this['sourceTarget'].addEventListener('input', this.sync.bind(this))
        this['outputTargets'].forEach(t => t.textContent = this['sourceTarget'].value)
    }

    sync(event) {
        this['outputTargets'].forEach(t => t.textContent = event.target.value)
    }
}
