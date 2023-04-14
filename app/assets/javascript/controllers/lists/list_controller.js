import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import Rails from '@rails/ujs'
import { isTestEnv } from "../../util/environment";

export default class extends Controller {

  static targets = ['link']

  connect() {
    const sortable = Sortable.create(this.element, {
      delay: 100,
      delayOnTouchOnly: true,
      onEnd: this.updatePosition,
      forceFallback: isTestEnv()
    });
  }

  setActive(id) {
    this.linkTargets.forEach((el, index) => {
      if(el.parentElement.id === `list_${id}`) {
        el.classList.add('active');
        // if a new list was added (at the end of the list) we want to scroll to it
        if(index === this.linkTargets.length - 1) {
          el.scrollIntoView();
        }
      } else {
        el.classList.remove('active');
      }
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
