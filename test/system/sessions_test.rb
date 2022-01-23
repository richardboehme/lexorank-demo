# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  should 'have different lists and items for different sessions' do
    visit root_path
    create_list('List from first session')
    assert_selector '.nav-item', count: 1

    Capybara.using_session(:other) do
      visit root_path
      assert_no_selector '.nav-item'
      create_list('List from other session')
      assert_selector '.nav-item', count: 1, text: 'List from other session'
    end

    visit root_path
    assert_selector '.nav-item', count: 1, text: 'List from first session'
  end
end
