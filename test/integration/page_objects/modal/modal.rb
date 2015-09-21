require_relative '../page_object'

class Modal < PageObject

  def initialize(element = nil)
    element ||= find('.modal')
  end

end