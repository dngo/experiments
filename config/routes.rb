Exp::Application.routes.draw do

  scope "api", :module => "api" do
    resources :games
    resources :users
  end

end
