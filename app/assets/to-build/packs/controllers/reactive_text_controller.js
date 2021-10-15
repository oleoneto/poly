import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "source", "output" ]

    connect() {
        console.log(this.sourceTarget.value);
        this.sourceTarget.addEventListener('keyup', () => this.sync())
    }

    sync() {
        console.log(this.sourceTarget.value);
        console.log(this.outputTarget.innerHTML);
        this.outputTarget.innerHTML = this.sourceTarget.value;
    }
}