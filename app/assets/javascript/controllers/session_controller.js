import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ['toggle', 'dropdown']

    connect() {
        document.addEventListener('click', (event) => {
            const wasClicked = event.composedPath().includes(this.element)
            if (!wasClicked) {
                this['dropdownTarget'].classList.toggle('hidden', true)
            }
        })
    }

    toggle() {
        this['dropdownTarget'].classList.toggle('hidden')
    }
}
