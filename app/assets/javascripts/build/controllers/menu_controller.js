import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['open', 'close', 'navigation']

  connect() {
  	// pass...
  }

  toggleMenu() {
  	const isOpen = !this.openTarget.classList.contains('hidden')
  	const isClosed = !this.closeTarget.classList.contains('hidden')


  	this.openTarget.classList.toggle('hidden', isOpen)
  	this.closeTarget.classList.toggle('hidden', isClosed)

  	this.navigationTarget.classList.toggle('hidden', isClosed)
  }
}
