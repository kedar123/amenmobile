xml.instruct!
  xml.prayers do 
    render :partial => 'prayerlist', :collection => @user.prayers, :as => :prayers, :locals => {:xml_override => xml,:host_with_port => @my_host_and_port}
  else
    
    xml.message "please log n to see the prayers"
  end  
    
  end 

