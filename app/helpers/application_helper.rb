module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def pronoun(user)
    if user.gender == 'male'
      'his'
    else
      'her'
    end
  end

  def son_or_daughter(child)
    if child.gender == 'male'
      'son'
    else
      'daughter'
    end
  end
end
