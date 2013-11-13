get '/status/:job_id' do
  
  jid=params[:job_id]
  
  @status=job_is_complete(jid)

erb :status

end
