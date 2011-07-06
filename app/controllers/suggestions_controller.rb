class SuggestionsController < MessagesController
  def index
    @suggestions = Suggestion.all(:conditions => ["message_visitors.user_id = ? OR base_public_messages.user_id = ? ",current_user.id,current_user.id],:joins => [:message_visitors],:order => "created_at DESC").paginate :page => params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.xml
    end
  end

  def new
    @suggestion = Suggestion.new(:org => current_user.org)
    @suggestion.message_visitors.build()
  end
end
