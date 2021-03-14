import { Controller } from "stimulus"
import { Tooltip } from "bootstrap";

export default class extends Controller {
  connect() {
    // TODO: see https://github.com/twbs/bootstrap/issues/32372
    new Tooltip(this.element, { animation: false });
  }
}
