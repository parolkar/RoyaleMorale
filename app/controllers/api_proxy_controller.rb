class ApiProxyController < ApplicationController
  protect_from_forgery except: :index
  def index
    
     conn = Faraday.new(:url => DIALOG_API_HOST) do |faraday|
       faraday.request  :url_encoded             # form-encode POST params
       faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
     end
     conn.basic_auth(DIALOG_API_USER, DIALOG_API_PASS)  

     path=params[:path]
     end_point = "#{DIALOG_API_PREFIX}/#{path}"
       
     resp = conn.get end_point, params if request.get?
    
     resp = conn.post end_point, params if request.post?
    
     render :json => "#{resp.body}", :status => resp.status
  end
  
end
