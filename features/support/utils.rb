#encoding: utf-8
#!/usr/bin/env ruby

require 'tmpdir'

class Utils
  
  def self.timestamp
    time = Time.new
    time.strftime('%Y%m%d%H%M%S%6N')
  end

  def self.windows(page)
    # Janela principal
    $window_main = page.driver.browser.window_handles.first
    # Ultima janela aberta
    $window_last = page.driver.browser.window_handles.last
  end
end
