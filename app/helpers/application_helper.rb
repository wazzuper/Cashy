module ApplicationHelper
  def user_avatar(user)
    if user.avatar.present?
      current_user.avatar
    else
      'default_avatar.png'
    end
  end
end
