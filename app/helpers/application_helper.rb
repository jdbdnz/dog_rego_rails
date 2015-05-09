module ApplicationHelper
  def horizontal_form_for(*params, &block)
    params[1][:html] = Hash.new if params[1][:html].nil?
    params[1][:html][:class] = 'form-horizontal'
    params[1][:defaults] = { input_html: { class: "form-control" }, wrapper: :horizontal, label_html: { class: "text-right" }, wrapper_html: {class: "form-group"} }
    simple_form_for(*params, &block)
  end

   def bootstrap_form_for(*params, &block)
    params[1][:defaults] = { input_html: { class: "form-control" }, label_html: { class: "text-left" }, wrapper_html: {class: "form-group clearfix"} }
    simple_form_for(*params, &block)
  end

  def format_date(date, options = {time: false})
    format = "%e %b %Y"
    format += " %l:%M %p" if options[:time] == true
    date.to_date.strftime(format) 
  end
end
