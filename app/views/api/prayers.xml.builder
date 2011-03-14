xml.instruct!
  xml.prayers do 
    render :partial => 'prayerlist', :collection => @user.prayers, :as => :prayers, :locals => {:xml_override => xml}
  end 

