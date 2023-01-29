import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  
  // turbo-modal#hideModal
  hideModal() {
    this.element.parentElement.removeAttribute("src")
    this.modalTarget.remove()
  }

  // спрячет модуль, когда произведено сохранение формы
  // action: turbo:submit-end->turbo-modal#submitEnd
  submitEnd(event) {
    if (event.detail.success) {
      this.hideModal()
    }
  }

  // спрячет модуль, когда клик вне модуля
  // action: click@window->turbo-modal#closeBackground
  closeBackground(event) {
    if (event && this.modalTarget.contains(event.target)) {
      return;
    }
    this.hideModal()
  }
}
