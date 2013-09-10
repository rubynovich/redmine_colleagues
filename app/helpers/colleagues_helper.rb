module ColleaguesHelper

  def profile_field_li(colleague, field)
    if colleague.send(field.to_s).present?
      "<li> #{colleague.send(field.to_s)} </li>".html_safe
    end
  end

  def mail_li(colleague)
    "<li class=\"email icon icon-email\"> #{mail_to(colleague.mail)} </li>".html_safe
  end

  def address_li(colleague)
    if colleague.address.present?
      city = colleague.address.split(',')[0]
      style = "background: url('../images/bullet_go.png') no-repeat scroll 0 50% transparent;"
      "<li class=\"icon\" style=\"#{style}\"> #{city} </li>".html_safe
    end
  end

  def phone_li(colleague)
    if colleague.phone.present?
      colleague.phone.split(/,\s+/).map{|ph| "<li class=\"phone icon icon-phone\"> #{ph.strip} </li>"}.join("\n").html_safe
    end
  end
      
end


