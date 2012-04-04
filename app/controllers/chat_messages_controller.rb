class ChatMessagesController < BaseController
  # GET /chat_messages
  # GET /chat_messages.xml
  def index
    @chat_messages = ChatMessage.search(params[:search]).paginate :page => params[:page],:per_page => 20,:order => "created_at DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chat_messages }
    end
  end

  # POST /chat_messages
  # POST /chat_messages.xml
  def create
    @chat_message = ChatMessage.new(params[:chat_message])

    @chat_message.save
    respond_to do |format|
      format.html { redirect_to(chat_messages_path("search[created_at_gte]" => 2.hours.ago)) }
      format.xml  { render :xml => @chat_message, :status => :created, :location => @chat_message }
    end
  end

end
