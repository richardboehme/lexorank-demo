module ApplicationHelper

  def flash_to_icon(type)
    case type.to_sym
    when :danger
      icon(:exclamation_triangle, height: 18, width: 18)
    when :success
      icon(:check, height: 18, width: 18)
    end
  end

  def icon(name, **options)
    content_tag(:svg, class: 'bi', width: '25', height: '25', fill: 'currentColor', **options) do
      tag.use 'xlink:href': "#{asset_pack_path('media/bootstrap-icons/bootstrap-icons.svg')}##{name.to_s.dasherize}"
    end
  end

end
