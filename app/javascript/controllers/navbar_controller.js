import { Controller } from "@hotwired/stimulus"

// Mobile burger toggle for the site navbar.
export default class extends Controller {
  static targets = ["menu", "button"]

  toggle() {
    const isOpen = this.menuTarget.classList.toggle("is-open")
    this.buttonTarget.setAttribute("aria-expanded", isOpen)
  }

  close() {
    this.menuTarget.classList.remove("is-open")
    this.buttonTarget.setAttribute("aria-expanded", "false")
  }
}
