import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = []

  connect() {
    window.addEventListener('trix-file-accept', (event) => {
      event.preventDefault()
      alert("File attachments are not supported at this time.")
    })
  }
}
