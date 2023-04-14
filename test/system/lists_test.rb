# frozen_string_literal: true

require 'application_system_test_case'

class ListsTest < ApplicationSystemTestCase
  setup do
    visit root_path
  end

  should 'create list' do
    within '.nav' do
      assert_no_selector '.nav-item'
    end

    create_list('List 1')

    within '.nav' do
      assert_selector '.nav-item', count: 1
      assert_selector '.nav-item > a.active', text: 'List 1'
    end

    assert find_field('New List').value.blank?

    within '#current_list' do
      assert_text 'List 1'
    end
  end

  should 'not create list with empty name' do
    within "form[action='#{lists_path}']" do
      click_on 'button'
    end
    assert_no_selector '.nav-item'
    if js?
      assert_text 'Error while creating a new list!'
      assert_text "Name can't be blank"
    end
  end

  should 'delete list and select next list' do
    4.times do |n|
      create_list("List #{n}")
    end

    assert_selector '.nav-item', count: 4
    assert_selector 'a.active', text: 'List 3'
    click_on 'List 1'
    assert_selector 'a.active', text: 'List 1'

    assert_difference -> { List.count }, -1 do
      click_on 'Delete'
      assert_selector '.nav-item', count: 3
      assert_selector 'a.active', text: 'List 2'
    end

    click_on 'List 3'
    assert_selector 'a.active', text: 'List 3'

    assert_difference -> { List.count }, -1 do
      click_on 'Delete'
      assert_selector '.nav-item', count: 2
      assert_selector 'a.active', text: 'List 2'
    end
  end

  should 'delete last list' do
    create_list('List')
    assert_difference -> { List.count }, -1 do
      click_on 'Delete'
      assert_no_selector '.nav-item'
    end
    assert_selector 'h5', text: 'Start by creating a new list!'
  end

  should 'change rank when moving lists around' do
    2.times do |n|
      create_list("List #{n}")
    end

    list_1, list_2 = *List.ranked.to_a

    assert list_2.rank > list_1.rank

    list_1_element = find("##{dom_id(list_1)}")
    list_2_element = find("##{dom_id(list_2)}")

    list_1_element.assert_selector '.rank-container', text: "Rank: #{list_1.rank}"
    list_2_element.assert_selector '.rank-container', text: "Rank: #{list_2.rank}"

    if js?
      list_2_element.drag_to list_1_element, steps: 10
    else
      list_1_element.assert_selector 'button.disabled > svg.bi-arrow-up'
      list_2_element.assert_selector 'button.disabled > svg.bi-arrow-down'
      list_2_element.find('button:not(.disabled)').click
      assert_selector '.nav-item > a.active', text: list_2.name
    end

    within list_2_element do
      assert_no_text 'g'
    end
    assert_not_equal list_2.rank, list_2.reload.rank
    assert list_2.rank < list_1.rank

    list_1_element = find("##{dom_id(list_1)}")
    list_2_element = find("##{dom_id(list_2)}")

    list_2_element.assert_selector '.rank-container', text: "Rank: #{list_2.rank}"

    all_lists = all('.nav-item')
    assert_equal list_2_element, all_lists.first
    assert_equal list_1_element, all_lists.last
  end
end
