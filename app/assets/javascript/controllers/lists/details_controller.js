import { Controller } from '@hotwired/stimulus'
import Sortable from 'sortablejs';
import Rails from "@rails/ujs";
import { isTestEnv } from '../../util/environment';

export default class extends Controller {

  static values = { id: Number };
  static targets = ['itemList'];

  connect() {
    this.dispatch('listAppeared', { detail: { id: this.idValue }})

    Sortable.create(this.itemListTarget, {
      delay: 100,
      delayOnTouchOnly: true,
      chosenClass: 'shadow',
      onEnd: this.updatePosition,
      forceFallback: isTestEnv()
    });
  }

  updatePosition(e) {
    const url = `${e.item.dataset.updatePositionPath}?position=${e.newIndex}`;
    fetch(url, {
      method: 'PATCH',
      credentials: 'same-origin',
      headers: { 'X-CSRF-Token': Rails.csrfToken() }
    })
    .then(response => response.json())
    .then(data => {
      e.item.querySelector('.rank-container').innerText = `Rank: ${data.rank}`;
    });
  }

}
