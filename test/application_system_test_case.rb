require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase

  # TODO: Remove once we upgrade to Rails 7
  Selenium::WebDriver.logger.ignore(:browser_options)

  def self.js?
    !ENV['NOJS']
  end

  def js?
    self.class.js?
  end

  driver = js? ? :selenium : :rack_test
  driven_by driver, using: :headless_chrome, screen_size: [1920, 1080]

  def create_list(name)
    fill_in 'New List', with: name
    assert_difference -> { List.ranked.count } do
      within "form[action='#{lists_path}']" do
        click_on 'button'
      end

      assert_selector '.nav-item', text: name

      if js?
        within '.toast-header' do
          assert_text 'List successfully created!'
          find('.btn-close').click
        end
      end
    end
  end

  def create_item(name, list)
    fill_in 'New Item', with: name
    assert_difference -> { list.items.ranked.count } do
      within "form[action='#{list_items_path(list)}']" do
        click_on 'button'
      end

      assert_selector '.list-group-item', text: name

      if js?
        within '.toast-header' do
          assert_text 'Item successfully created!'
          find('.btn-close').click
        end
      end
    end
  end

end
