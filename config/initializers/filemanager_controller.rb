#修改FileManager中不支持cn locale的问题
class Tinymce::FilemanagerController < ActionController::Base
  def tinymce_managed_js
    @manager_lang = "en"
    supported_languages = ["cs", "de", "en", "es", "fr", "it", "ja", "pl", "pt", "ru", "sk", "uk", "zh","cn"]
    @manager_controller = params[:manager]
    if supported_languages.include?(I18n.default_locale.to_s)
      @manager_lang = I18n.default_locale.to_s
    end
    response.headers["Content-Type"] = "text/javascript; charset=utf-8"
    render :template =>"tinymce_filemanager/tinymce_managed_js", :layout => false
  end
end
