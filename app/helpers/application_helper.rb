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
    elsif user.gender == 'female'
      'her'
    else
      ''
    end
  end

  def son_or_daughter(child)
    if child.gender == 'male'
      'son'
    else
      'daughter'
    end
  end

  def grader(grade)
    case grade
    when 'K'
      'kindergartener'
    when '1st'
      'first grader'
    when '2nd'
      'second grader'
    when '3rd'
      'third grader'
    when '4th'
      'fourth grader'
    when '5th'
      'fifth grader'
    else
      'student'
    end
  end
end
