helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end


get '/' do
    @posts = Post.order(created_at: :desc)
    erb(:index)
end

get '/signup' do        # if user navigates to the path "/signup",
    @user = User.new    # setup empty @user object
    erb(:signup)        # render "app/views/signup.erb"
end

post '/signup' do
    
    # grab user input values from params
    email       = params[:email]
    avatar_url  = params[:avatar_url]
    username    = params[:username]
    password    = params[:password]
    
    
        # instantiate and save user
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})
    
    if @user.save
        "User #{username} saved!"
        
    else 
        erb(:signup)
    end
    
end
    
get '/login' do        # if user navigates to the path "/login",
        erb(:login)        # render "app/views/login.erb"
end
    
post '/login' do
    # grab user input values from params
    
    username    = params[:username]
    password    = params[:password]
    
    
        # instantiate and save user
    user = User.find_by(username: username)

    if user && user.password == password
        session[:user_id] = user.id
         redirect to("/")
    else 
        @error_message = "Login failed"
        erb(:login)
    
    end
end

get '/logout' do
    session[:user_id] = nil
    redirect to("/")
    
end

get '/posts/new' do
    @post = Post.new
    erb(:"posts/new")
end

post '/posts' do
    photo_url = params[:photo_url]
    
    #instantiate new post
    @post = Post.new({photo_url: photo_url, user_id: current_user.id})
    
    #if @post validates, save
    if @post.save
        redirect(to('/'))
        
    else
        erb(:"posts/new")
    end    
end

get '/posts/:id' do
    @post = Post.find(params[:id])
    erb(:"posts/show")
end







    
    

    

    
