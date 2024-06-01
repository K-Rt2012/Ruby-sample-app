class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "user_default.png"
    )
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/index")
    else
      flash[:notice] = "ユーザー登録に失敗しました"
      render("users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:id])    
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_image/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザーを編集しました"
      redirect_to("/users/#{@user.id}")
    else
      redirect_to("/users/#{@user.id}/edit")
    end
  end
end
