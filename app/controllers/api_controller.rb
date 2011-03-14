class ApiController < ApplicationController
  # GET /apis
  # GET /apis.xml
  
  def create_prayer
    @prayer = Prayer.new(params[:prayer])
      if params[:prayer][:title].blank? or params[:prayer][:description].blank? 
          flash[:notice] = "Please Enter A Prayer All Fields"  
          redirect_to :back
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
  
end
