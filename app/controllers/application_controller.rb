class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # standard json response available for all controllers
  # http://paydrotalks.com/posts/45-standard-json-response-for-rails-and-jquery/
  def render_json_response(type, hash)
    unless [ :ok, :redirect, :error ].include?(type)
      raise "Invalid json response type: #{type}"
    end

    # To keep the structure consistent, we'll build the json
    # structure with the default properties.
    #
    # This will also help other developers understand what
    # is returned by the server by looking at this method.
    default_json_structure = {
        :status => type,
        :html => nil,
        :message => nil,
        :to => nil }.merge(hash)

    render_options = {:json => default_json_structure}
    render_options[:status] = 400 if type == :error

    render(render_options)
  end

  def notice_message(message, title= 'Notice!')
    flash_message title: title, message: message, type: FlashMessage::TYPE_NOTICE
  end

  def error_message(message, title= 'Error!')
    flash_message title: title, message: message, type: FlashMessage::TYPE_ERROR
  end

  def success_message(message, title= 'Success!')
    flash_message title: title, message: message, type: FlashMessage::TYPE_SUCCESS
  end

  def flash_message(args)
    flash[:message] = Array.new
    flash[:message] << FlashMessage.new(
        args[:title],
        args[:message],
        args[:type]
    )
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then
        Csv.new(file.path, nil, :ignore)
      when ".xls" then
        Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then
        Roo::Excelx.new(file.path, nil, :ignore)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end

end
