import { Controller } from "stimulus";
import Toast from "bootstrap/js/dist/toast";

export default class extends Controller {

  connect() {
    new Toast(this.element, {}).show();
  }

}
