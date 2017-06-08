package Ba;
use Dancer2;

#use Dancer2::Plugin::Auth::Extensible
     
#my Dancer2::Plugin::Auth::Extensible->(new);


  my $flash;

 sub set_flash {
     my $message = shift;

     $flash = $message;
 }

 sub get_flash {

     my $msg = $flash;
     $flash = "";

     return $msg;
 } 





    hook before => sub {
        if (!session('user') && request->dispatch_path !~ m{^/login}) {
            forward '/login', { requested_path => request->dispatch_path };
        }
    };

    get '/' => sub { template 'index'; };

    

    get '/login' => sub {
        
        template 'login', { path => param('requested_path') };
    };

    post '/login' => sub {
        # Validate the username and password they supplied
        if (param('user') eq 'bosna' && param('pass') eq 'tr0n') {
            session user => param('user');
            redirect param('path') || '/';
        } else {
            redirect '/login?failure=1'; 
        }
    };
    
                          
    post '/login' => sub {
        my $user_value = body_parameters->get('user');
        my $pass_value = body_parameters->get('pass');

        my $user = database->quick_select('users',
            { username => $user_value }
        );
        if (!$user) {
            warning "Failed login for unrecognised user $user_value";
            redirect '/login?failure=1';
        } else {
            if (Crypt::SaltedHash->validate($user->{password}, $pass_value))
            {
                debug "Password correct";
                # Logged in successfully
                session user => $user;
                redirect body_parameters->get('path') || '/';
            } else {
                debug("Login failed - password incorrect for " . $user_value);
                redirect '/login?failure=1';
            }
        }
    };
    
    get '/logout' => sub {
    app->destroy_session;
    set_flash('You are logged out.');
    redirect '/';};

    dance();
