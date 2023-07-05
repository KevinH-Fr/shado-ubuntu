module UsersHelper
  def user_role(user)
    user = User.find(user) if user.is_a?(Integer)  # Convert ID to User object if necessary

    return unless user.present?

    if user.fan.present?
      "fan"
    elsif user.athlete.present?
      "athlete"
    end
  end

  def user_role_id(user)
    user = User.find(user) if user.is_a?(Integer)  # Convert ID to User object if necessary

    return unless user.present?

    if user.fan.present?
      user.fan.id
    elsif user.athlete.present?
      user.athlete.id
    end
  end

  def user_name(user)
    user = User.find(user) if user.is_a?(Integer)  # Convert ID to User object if necessary

    return unless user.present?

    if user.fan.present?
      user.fan.pseudo
    elsif user.athlete.present?
      user.athlete.name
    end
  end
end
