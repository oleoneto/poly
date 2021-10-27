import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "source", "output" ]

    connect() {
        this['sourceTarget'].addEventListener('input', (event) => this.sync(event))
    }

    sync(event) {
        this['outputTargets'].forEach(t => t.textContent = event.target.value);
    }
}