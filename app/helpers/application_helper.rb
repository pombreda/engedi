module ApplicationHelper

  def current_uri
    request.env['ORIGINAL_FULLPATH']
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def flash_m
    flash[:message]
  end

end
