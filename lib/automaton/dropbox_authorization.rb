# all Dropbox related functions are placed in the following module
module DropboxAuthorization
  # Application credentials
  APP_KEY =    '*****'
  APP_SECRET = '*****'

  def set_client
    flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
    authorization_url = flow.start

    puts "Go to: \n#{authorization_url}"
    print 'Enter the authorization code here: '
    access_token, _user_id = flow.finish(gets.strip)

    DropboxClient.new(access_token)
  end
end
