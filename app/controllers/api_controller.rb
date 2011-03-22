class ApiController < ApplicationController
  # GET /apis
  # GET /apis.xml
  before_filter :get_my_ip_address
  
  def get_my_ip_address
      @my_host_and_port = request.host_with_port
  end  
  def friend_request
      friend = User.find_by_email(params[:user][:email])
      iphoneloggedinuser = User.find(params[:user][:id])
      invitation_sent = InvitationSent.where(["from_email = ? and to_email = ?",iphoneloggedinuser.email,params[:user][:email]])
      if  invitation_sent.blank?
             invsnt=InvitationSent.new(:from_email=>iphoneloggedinuser.email,:to_email=>params[:user][:email])
             invsnt.save
              if friend.blank?
                  Notifier.friend_request(params[:user][:email],iphoneloggedinuser,request.host_with_port).deliver       
              else  
                  iphoneloggedinuser.invite  friend
              end
              @noticesent = "Your Invitation Has Been Sent"
      else  
              @noticesent = "You Already Sent The Invitation"
      end              
      
     respond_to do |format|
      format.html {render :text=>@noticesent}
      format.xml  
    end
      
 end  
  
 def get_invitation_pending
     @user = User.find(params[:user][:id])       
     @pending_invited_by = @user.pending_invited_by
 end   
  
 def accept_invitation
    @user = User.find(params[:user][:id])       
    @friend = User.find(params[:friend][:id]) 
    if params[:user][:accept] == "1"
          @user.approve  @friend
    else
          @user.reject  @friend
    end  
   
   
    respond_to do |format|
      format.html 
      format.xml  
    end
         

 end   
  
 def rejected_friends
    @user = User.find(params[:user][:id])
    @rejected_friends = @user.rejected
    @rejected_friends_req = @user.find_friend_ship_rejected
    respond_to do |format|
      format.html 
      format.xml  
    end
 end   
  
  
  def create_prayer
    @prayer = Prayer.new(params[:prayer])
      if params[:prayer].blank? or params[:prayer][:title].blank? or params[:prayer][:description].blank? 
          flash[:notice] = "Please Enter A Prayer All Fields"  
          respond_to do |format|
               format.xml  { render :xml => "<error>please enter proper field</error>", :status => :unprocessable_entity }  
               format.html {redirect_to :back}    
          end
      else
          respond_to do |format|
            if @prayer.save
              format.html { redirect_to "/" }
              format.xml  { render :xml => @prayer, :status => :created }
            else
              format.html { render :action => "new" }
              format.xml  { render :xml => @prayer.errors, :status => :unprocessable_entity }
            end
          end
      end
  end
  
  
  def index
    @apis = Api.all
   respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apis }
    end
  end

  # GET /apis/1
  # GET /apis/1.xml
  def show
    @api = Api.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @api }
    end
  end

  # GET /apis/new
  # GET /apis/new.xml
  def new
    @api = Api.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @api }
    end
  end

  # GET /apis/1/edit
  def edit
    @api = Api.find(params[:id])
  end

  # POST /apis
  # POST /apis.xml
  def create
    @api = Api.new(params[:api])

    respond_to do |format|
      if @api.save
        format.html { redirect_to(@api, :notice => 'Api was successfully created.') }
        format.xml  { render :xml => @api, :status => :created, :location => @api }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @api.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apis/1
  # PUT /apis/1.xml
  def update
    @api = Api.find(params[:id])

    respond_to do |format|
      if @api.update_attributes(params[:api])
        format.html { redirect_to(@api, :notice => 'Api was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @api.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apis/1
  # DELETE /apis/1.xml
  def destroy
    @api = Api.find(params[:id])
    @api.destroy

    respond_to do |format|
      format.html { redirect_to(apis_url) }
      format.xml  { head :ok }
    end
  end

  def testuser
      @user=User.find(:all)
  end  
  
  def prayers
     @user = User.find(params[:id])
      respond_to do |wants|
      wants.html 
      wants.xml
    end 
  end  
  
  def login
        @user =  User.authenticate(params[:name], params[:password])
      if @user.blank?
                 userstatus="Not Authenticate"
      else  
                 userstatus="Authenticate"
      end  
    respond_to do |wants|
      wants.html {render :text=>userstatus}
      wants.xml
    end 
  end   
  
  def create_user
    #logout_keeping_session!#in production need to be comment out
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      #notice = "Logged in Successfully"
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #here i need to send email to the registered user
      Notifier.send_welcome_registration(@user,request.host_with_port).deliver
#      if !session[:friendid].blank?
#        tempuser = User.find(session[:friendid])
#        session[:friendid] = nil
#        self.current_user = @user # !! now logged in
#        tempuser.invite current_user
#        notice = "Logged in Successfully Please Accept The Invitation Of Your Friend By Clicking On   Invitation #Pending" 
#      end#this will be later implemented after the session is get maintain by iphone and rails server bo cookie
#      flash[:notice]=notice
#      redirect_back_or_default('/')
       respond_to do |wants|
              wants.html {render :text=>"User is created please login"}
              #wants.xml  { render :xml => @user, :status => :user_created }
              wants.xml  #{ render :xml => "<>", :status => :user_created }
        end 
      
    else
#      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is #above)."
#      render :action => 'new'
#    end
        respond_to do |wants|
              wants.html {render :text=>"there is error in creating the user"}
              wants.xml  #{ render :xml => @user.errors, :status => :unprocessable_entity }
        end 
  end  
end  
  
  def get_friend_list
      @user = User.find(params[:id])       
      @userallfriend = @user.friends
  end
  
end
