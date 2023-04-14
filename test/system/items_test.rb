# frozen_string_literal: true

require 'application_system_test_case'

class ItemsTest < ApplicationSystemTestCase
  setup do
    visit root_path
    create_list('List 1')
    @list = List.first
  end

  should 'create items' do
    within '#items' do
      assert_no_selector '.list-group-item'
    end

    create_item('Item 1', @list)

    within '#items' do
      assert_selector '.list-group-item', count: 1, text: 'Item 1'
    end

    assert find_field('New Item').value.blank?
  end

  should 'not create item with empty name' do
    within "form[action='#{list_items_path(@list)}']" do
      click_on 'button'
    end
    assert_no_selector '.list-group-item'
    if js?
      assert_text 'Error while creating a new item!'
      assert_text "Name can't be blank"
    end
  end

  should 'have individual items per list' do
    create_item('Item 1', @list)

    create_list('List 2')
    within '#items' do
      assert_no_selector '.list-group-item'
    end

    list_2 = List.find_by(name: 'List 2')
    create_item('Item 2', list_2)
    within '#items' do
      assert_selector '.list-group-item', count: 1, text: 'Item 2'
    end

    click_on 'List 1'
    within '#items' do
      assert_selector '.list-group-item', count: 1, text: 'Item 1'
    end
  end

  should 'remove item' do
    create_item('Item 1', @list)
    assert_difference -> { @list.items.ranked.count }, -1 do
      within ".list-group-item form[action='#{list_item_path(@list.items.first, list_id: @list)}']" do
        click_on 'button'
      end
      assert_no_selector '.list-group-item'
    end
  end

  should 'move items around' do
    2.times do |n|
      create_item("Item #{n}", @list)
    end

    item_1, item_2 = *@list.items.ranked.to_a

    assert item_2.rank > item_1.rank

    item_1_element = find("##{dom_id(item_1)}")
    item_2_element = find("##{dom_id(item_2)}")

    item_1_element.assert_selector '.rank-container', text: "Rank: #{item_1.rank}"
    item_2_element.assert_selector '.rank-container', text: "Rank: #{item_2.rank}"

    if js?
      item_2_element.drag_to item_1_element, steps: 10
    else
      item_1_element.assert_selector 'button.disabled > svg.bi-arrow-up'
      item_2_element.assert_selector 'button.disabled > svg.bi-arrow-down'
      item_2_element.find('.btn-group button:not(.disabled)').click
      assert_selector '.list-group:first-child', text: item_2.name
    end

    within item_2_element do
      assert_no_text item_2.rank
    end
    assert_not_equal item_2.rank, item_2.reload.rank
    assert item_2.rank < item_1.rank

    item_1_element = find("##{dom_id(item_1)}")
    item_2_element = find("##{dom_id(item_2)}")

    item_2_element.assert_selector '.rank-container', text: "Rank: #{item_2.rank}"

    all_items = all('.list-group-item')
    assert_equal item_2_element, all_items.first
    assert_equal item_1_element, all_items.last
  end
end
