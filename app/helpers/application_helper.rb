module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def active_if(*paths)
    'active' if paths.any? do |path|
      case path
        when Array
          controller_name == path[0].to_s && action_name == path[1].to_s
        when Proc
          path.call
        else
          controller_name == path.to_s
      end
    end
  end


end
