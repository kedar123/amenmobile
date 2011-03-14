class HomesController < ApplicationController
  # GET /homes
  # GET /homes.xml

  def index
    p "im coming here"
    p @facebook_cookies["access_token"]
       if @facebook_cookies != nil   
        @facebook_cookies["access_token"]
        @graph = Koala::Facebook::GraphAPI.new(@facebook_cookies["access_token"])
	      @friends = @graph.get_connections("me", "friends")
        p @friends
        # p "my picture is blank"
         @mypicture=@graph.get_picture(1074997208) 
        # p "my picture is blank"
        # p   @graph.get_picture("koppel")
        @rest = Koala::Facebook::RestAPI.new(@facebook_cookies["access_token"])
       else 
          redirect_to "/login"
       end   
#         permissions = @rest.fql_query("select #{read_stream,publish_stream,offline_access,email} from permissions where uid = #{1074997208}")
#p permissions
#p "these are my permission"

       # for friend in @friends 
     #      p  friend.values_at("id")[0].to_s    
     # p	@rest.fql_query("SELECT email,contact_email,email_hashes,proxied_email FROM user WHERE uid=#{friend.values_at('id')[0].to_s}")
      #  end
  end

  # GET /homes/1
  # GET /homes/1.xml
  def show
    @home = Home.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/new
  # GET /homes/new.xml
  def new
    @home = Home.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/1/edit
  def edit
    @home = Home.find(params[:id])
  end

  # POST /homes
  # POST /homes.xml
  def create
    @home = Home.new(params[:home])

    respond_to do |format|
      if @home.save
        format.html { redirect_to(@home, :notice => 'Home was successfully created.') }
        format.xml  { render :xml => @home, :status => :created, :location => @home }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /homes/1
  # PUT /homes/1.xml
  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        format.html { redirect_to(@home, :notice => 'Home was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.xml
  def destroy
    @home = Home.find(params[:id])
    @home.destroy

    respond_to do |format|
      format.html { redirect_to(homes_url) }
      format.xml  { head :ok }
    end
  end
end
