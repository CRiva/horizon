require_relative '../poltergeist_helper'

class PageObject

  TIMEOUT = 50.freeze

  attr_reader :element

  def initialize(element = nil)
    @element = element
  end

  def page
    Capybara.current_session
  end

  # Don't wait when using Capybara's #find unless specified otherwise.
  def find(css, params={})
    default_params = { wait: false }.merge(params)
    page.find(css, default_params)
  rescue Capybara::ElementNotFound
    raise "'#{css}' was not found."
  end

  #########
  # Waits #
  #########

  def wait_for_ajax(time_out = TIMEOUT)
    time_out.times do
      page.evaluate_script('jQuery.active').zero? ? true : sleep(0.1)
    end
    raise "Ajax never finished running."
  end

  def wait_for_css(css, time_out = TIMEOUT)
    raise 'Page was blank' if page.blank?
    unless page.has_css?(css, wait: time_out)
      raise "Page never loaded '#{css}'"
    end
  end

  def wait_for_element_css(css, time_out = TIMEOUT)
    raise 'Element does not exist' if element.nil?
    unless element.has_css?(css, wait: time_out)
      raise "Page Object never loaded '#{css}'"
    end
  end

  def wait_for_css_to_go_away(css, time_out = TIMEOUT)
    unless page.has_no_css?(css, wait: time_out)
      raise "'#{css}' never went away"
    end
  end
end
