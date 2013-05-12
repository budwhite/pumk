module ApplicationHelper
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
