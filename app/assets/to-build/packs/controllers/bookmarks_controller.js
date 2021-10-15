import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ['icon']

    connect() {
        // this.element.textContent = "Hello World!"
        // TODO: Implement bookmark action
    }

    bookmark() {
        console.log(this.element.dataset.meta);
        this.iconTarget.setAttribute('fill', this.iconTarget.getAttribute('fill') === 'currentColor' ? 'none' : 'currentColor')
        // fetch(`/mentions.json?query=${value}`)
        //     .then(response => response.json())
        //     .then(users => callback(users))
        //     .catch(error => callback([]))
    }
}
