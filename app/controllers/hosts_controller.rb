class HostsController < ApplicationController
  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hosts }
      format.yaml { render :text => @hosts.to_yaml }
    end
  end

  # GET /hosts/1
  # GET /hosts/1.json
  # GET /hosts/1.yaml
  def show
    @host = Host.find(params[:id])

    json = Hash.new
    json[:host] = @host.name
    #json.update(:hostings => [ @host.box.name ] ) unless @host.box_id.nil?
    json.update(:traits =>  @host )
    json.update(:extendedtraits =>  @host.host_attributes.map { |a| {"#{a.name}" =>  "#{a.value}"} } ) unless @host.host_attributes.nil?
    json.update(:tags => @host.tags.map {|t| "#{t.name}" } ).flatten unless @host.tags.empty?
    if params[:notes] == "true"
      json.update(:Notes => @host.comments.map { |c| "#{c.comment} (#{c.created_at})"}).flatten unless @host.comments.empty?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: json }
      format.yaml { render :text => json.to_yaml }
    end
  end

  # GET /hosts/new
  # GET /hosts/new.json
  def new
    @host = Host.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @host }
    end
  end

  # GET /hosts/1/edit
  def edit
    @host = Host.find(params[:id])
  end

  # POST /hosts
  # POST /hosts.json
  def create
    if Host.exists?(:name => params[:host][:name])
      @host = Host.new(params[:host])
      flash[:error] = "Host #{params[:host][:name]} exists."
      message = { "message" => "Host #{params[:host][:name]} exists" }
      respond_to do |format|
        format.html { redirect_to :hosts, notice: 'Host #{@host} exists.' }
        format.json { render json: message }
      end
    else
      @host = Host.new(params[:host])
      respond_to do |format|
        if @host.save
          format.html { redirect_to @host, notice: 'Host was successfully created.' }
          format.json { render json: @host, status: :created, location: @host }
        else
          format.html { render action: "new" }
          format.json { render json: @host.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PUT /hosts/1
  # PUT /hosts/1.json
  def update
    @host = Host.find(params[:id])

    params[:host].each_with_index do |p, blah|
      ## special case for the tag_list...
      case p[0]
        when "tag"
          @host.tag_list = @host.tag_list + ["#{p[1]}"] unless @host.tag_list.include? p[1]
        when "rtag"
          @host.tag_list = @host.tag_list - ["#{p[1]}"]
        when "note"
          note = Comment.new
          note.comment = p[1]
          @host.comments = @host.comments + [ note ]
      else
        @host.send("#{p[0]}=", p[1])
      end
    end

    respond_to do |format|
      if @host.save
        format.html { redirect_to @host, notice: 'Host was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host = Host.find(params[:id])
    @host.destroy

    respond_to do |format|
      format.html { redirect_to hosts_url }
      format.json { head :no_content }
    end
  end

  #def tagged
  #  if params[:tag].present?
  #    @hosts = Host.tagged_with(params[:tag])
  #  else
  #    @hosts = Host.hostall
  #  end
  #end

  # GET cli/list_hosts.json
  # GET cli/list_hosts.yaml
  def list_hosts
    @hosts = Host.select(:name).all.map(&:name)

    respond_to do |format|
      format.json { render json: @hosts}
      format.yaml { render :text => @hosts.to_yaml }
    end
  end

  def list_host_details
    json = Hash.new
    @hosts = Host.find(:all)
    #@hosts.each do |host|
    #  json.update(:traits =>  host )
    #  json.update(:extendedtraits =>  host.host_attributes.map { |a| {"#{a.name}" =>  "#{a.value}"} } ) unless host.host_attributes.nil?
    #end
    #json.update(:traits =>  @hosts )
    #json.update(:extendedtraits =>  @hosts.host_attributes.map { |a| {"#{a.name}" =>  "#{a.value}"} } ) unless @hosts.host_attributes.nil?
    respond_to do |format|
      format.json { render json: @hosts}
      format.yaml { render :text => @hosts.to_yaml }
    end
  end


end
