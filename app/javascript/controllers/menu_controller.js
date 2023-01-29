import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["menuContent", "openButton", "closeButton", "active"]
  static values = { open: Boolean }

  connect() {
    if (this.openValue) {
      this.openMenu()
    } else {
      this.closeMenu()
    }
  }

  toggleMenu() {
    if (this.menuContentTarget.hidden == true) {
      this.openMenu()
    } else {
      this.closeMenu()
    }
  }

  openMenu() {
    this.menuContentTarget.hidden = false
    try {
      this.openButtonTarget.hidden = true
      this.closeButtonTarget.hidden = false 
    } catch {}
  }

  closeMenu() {
    this.menuContentTarget.hidden = true
    try {
      this.openButtonTarget.hidden = false
      this.closeButtonTarget.hidden = true 
    } catch {}
  }
  
}
