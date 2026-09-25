import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Replaces the browser's native confirm() for data-turbo-confirm actions
// with the win98-styled <dialog> this controller manages.
export default class extends Controller {
  static targets = [ "message" ]

  connect() {
    Turbo.config.forms.confirm = (message) => this.show(message)
  }

  show(message) {
    this.messageTarget.textContent = message
    this.element.showModal()

    return new Promise((resolve) => {
      this.resolve = resolve
    })
  }

  confirm() {
    this.element.close()
    this.resolve?.(true)
  }

  cancel() {
    this.element.close()
    this.resolve?.(false)
  }
}
