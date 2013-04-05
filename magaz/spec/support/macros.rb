module Macros
  def login
      visit '/login'
      find('.vkontakte').click 
  end

  def debug
    save_and_open_page
  end
end