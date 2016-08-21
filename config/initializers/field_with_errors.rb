# Specify the proc used to decorate input tags that refer to
# attributes with errors. Overridden in order to dasherize the class.
# Original from:
# https://github.com/rails/rails/blob/master/actionview/lib/action_view/base.rb#L144
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "<div class=\"field-with-errors\">#{html_tag}</div>".html_safe
end
