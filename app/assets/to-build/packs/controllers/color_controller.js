import { Controller } from 'stimulus'

export default class extends Controller {
  get trix() {
    return this.element.children[0];
  }

  get colorTest() {
    return /color#[0-9a-f]{3,6}/gi
  }

  connect() {
    let content = this.trix.innerHTML
    let formatted = content.replace(this.colorTest, this._color)
    this.trix.innerHTML = formatted
  }

  _color(value, position, offset) {
    // Drop the color preffix
    const color = value.replace('color', '');

    return `
    <div class="tooltip" style="background: ${color}">
      <span class="tooltip-text" style="background: ${color}">${color}</span>
    </div>
    `
  }
}
