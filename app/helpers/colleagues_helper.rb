module ColleaguesHelper

  def profile_field_li(field)
    if @colleague.send(field.to_s).present?
      "<li> #{colleague.field} </li>" 
    end
  end

  def phone_li(ph_str)
    "<li class=\"phone icon icon-phone\"> #{ph_str} </li>"
  end

  def phones
    if @colleague.phone.present?
      @colleague.phone.split(',').map{|ph| phone_li(ph.strip)+"\n"}
    end
  end
      
end
