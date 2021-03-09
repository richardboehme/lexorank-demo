import { Controller } from "stimulus"
import { useDispatch } from 'stimulus-use'
import Sortable from 'sortablejs';
import Rails from "@rails/ujs";

export default class extends Controller {

  static values = { id: Number };
  static targets = ['itemList'];

  connect() {
    useDispatch(this);
    this.dispatch('listAppeared', { id: this.idValue })

    Sortable.create(this.itemListTarget, {
      onEnd: this.updatePosition
    });
  }

  updatePosition(e) {
    const url = `${e.item.dataset.updatePositionPath}?position=${e.newIndex}`;
    fetch(url, {
      method: 'PATCH',
      credentials: 'same-origin',
      headers: { 'X-CSRF_Token': Rails.csrfToken() }
    })
    .then(response => response.json())
    .then(data => {
      e.item.querySelector('.rank-container').innerText = `Rank: ${data.rank}`;
    });
  }

}
