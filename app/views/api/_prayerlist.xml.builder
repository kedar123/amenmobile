xml = xml_override

 xml.prayer do
    xml.id prayers.id
    xml.title prayers.title
    xml.description prayers.description
    xml.lat prayers.lat
    xml.lang prayers.lang
    if prayers.user.binary_data.blank?
       xml.prayer_image "http://#{host_with_port}/images/blank.jpeg"
    else  
       xml.prayer_image "http://#{host_with_port}/users/code_image/#{prayers.user.id}"
    end  
    
 end

