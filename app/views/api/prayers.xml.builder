xml.instruct!
  xml.prayers do 
    render :partial => 'prayerlist', :collection => @user.prayers, :as => :prayers, :locals => {:xml_override => xml,:host_with_port => @my_host_and_port}
  end 

