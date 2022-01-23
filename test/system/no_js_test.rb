# frozen_string_literal: true

require 'application_system_test_case'

class NoJsTest < ApplicationSystemTestCase
  unless js?
    should 'show no js hint' do
      visit root_path
      within '.navbar-expand-md .no-js-show', match: :first do
        assert_text 'JavaScript is disabled. The site will work well but may not run as smooth (especially moving objects around is kind of hard without JavaScript).'
        assert_selector 'svg.bi-exclamation-triangle.text-warning'
      end
    end
  end
end
