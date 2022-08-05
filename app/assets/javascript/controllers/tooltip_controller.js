import { Controller } from "@hotwired/stimulus"
import Tooltip from "bootstrap/js/dist/tooltip";

export default class extends Controller {
  connect() {
    new Tooltip(this.element);
  }
}
