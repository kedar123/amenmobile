xml.instruct!
xml.users do
  if !@user.blank?
      xml.id @user.id
      xml.login @user.login
  else  
      xml.login "unsuccessfull"
  end   
end


