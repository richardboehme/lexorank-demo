import Rails from "@rails/ujs"
Rails.start()

import { Turbo } from "@hotwired/turbo-rails"

// Only import the plugins that we need to optimise bundle size
import 'bootstrap/js/dist/collapse'

// Only import the icons that we need to optimise bundle size
import 'bootstrap-icons/icons/plus.svg'
import 'bootstrap-icons/icons/list.svg'
import 'bootstrap-icons/icons/code-slash.svg'
import 'bootstrap-icons/icons/github.svg'
import 'bootstrap-icons/icons/exclamation-triangle.svg'
import 'bootstrap-icons/icons/check.svg'
import 'bootstrap-icons/icons/trash.svg'

import '../stylesheet'
import '../javascript/controllers'
