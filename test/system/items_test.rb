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

    list2 = List.find_by(name: 'List 2')
    create_item('Item 2', list2)
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

    item1, item2 = *@list.items.ranked.to_a

    assert item2.rank > item1.rank

    item1_element = find("##{dom_id(item1)}")
    item2_element = find("##{dom_id(item2)}")

    item1_element.assert_selector '.rank-container', text: "Rank: #{item1.rank}"
    item2_element.assert_selector '.rank-container', text: "Rank: #{item2.rank}"

    if js?
      item2_element.drag_to item1_element
    else
      item1_element.assert_selector 'button.disabled > svg.bi-arrow-up'
      item2_element.assert_selector 'button.disabled > svg.bi-arrow-down'
      item2_element.find('.btn-group button:not(.disabled)').click
      assert_selector '.list-group:first-child', text: item2.name
    end

    assert_not_equal item2.rank, item2.reload.rank
    assert item2.rank < item1.rank

    item1_element = find("##{dom_id(item1)}")
    item2_element = find("##{dom_id(item2)}")

    item2_element.assert_selector '.rank-container', text: "Rank: #{item2.rank}"

    all_items = all('.list-group-item')
    assert_equal item2_element, all_items.first
    assert_equal item1_element, all_items.last
  end

end
