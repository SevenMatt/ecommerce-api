<<<<<<< HEAD
class ApplicationController < ActionController::API
=======
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
>>>>>>> a9599b5 (Atualização)
end
