# frozen_string_literal: true

module ApplicationHelper
  def flash_to_icon(type)
    case type.to_sym
    when :danger
      icon(:exclamation_triangle, height: 18, width: 18)
    when :success
      icon(:check, height: 18, width: 18)
    end
  end

  def icon(name, **)
    inline_svg_tag("static/#{name.to_s.dasherize}.svg", height: 25, width: 25, **)
  end

  # We use our own implementation instead of link_to(method: :delete) to allow
  # to site to be used without any js
  def delete_button(url, form: {}, button: {}, &block)
    form_with(**form, url: url, method: :delete) do |f|
      f.button button, &block
    end
  end
end
