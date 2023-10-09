import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="instant-search"
export default class extends Controller {
  static targets = ["input", "results"]

  update() {
    const url = `/?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then(data => {
        this.resultsTarget.innerHTML = data
      })
  }
}
