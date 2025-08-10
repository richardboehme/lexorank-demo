# frozen_string_literal: true

require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def self.js?
    !ENV["NOJS"]
  end

  delegate :js?, to: :class

  driver = js? ? :cuprite : :rack_test
  driven_by(
    driver,
    using: :chrome,
    screen_size: [1920, 1080],
    options: {
      headless: %w(0 no false).exclude?(ENV.fetch("HEADLESS", nil))
    }
  )

  def create_list(name)
    fill_in "New List", with: name
    assert_difference -> { List.ranked.count } do
      within "form[action='#{lists_path}']" do
        click_on "button"
      end

      assert_selector ".nav-item", text: name

      if js?
        within ".toast-header" do
          assert_text "List successfully created!"
          find(".btn-close").click
        end
      end
    end
  end

  def create_item(name, list)
    fill_in "New Item", with: name
    assert_difference -> { list.items.ranked.count } do
      within "form[action='#{list_items_path(list)}']" do
        click_on "button"
      end

      assert_selector ".list-group-item", text: name

      if js?
        within ".toast-header" do
          assert_text "Item successfully created!"
          find(".btn-close").click
        end
      end
    end
  end
end
