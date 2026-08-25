import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["message"]
  connect() {
    console.log("Toggle controller connected")
  }

  toggle() {
    // this.element.classList.toggle("hidden")
    this.messageTarget.classList.toggle("hidden")
  }
}
