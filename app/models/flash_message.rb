class FlashMessage

  TYPE_NOTICE = "alert"
  TYPE_ERROR = "danger"
  TYPE_SUCCESS = "success"

  attr_accessor :title, :message, :type

  def initialize(title, message, type = TYPE_NOTICE)
    @type = type
    @title = title
    @message = message
  end

  def to_s
    hsh = {
        title: @title,
        text: @message,
        class_name: @type,
        position: 'top-right'
    }
    hsh.to_json
  end

end