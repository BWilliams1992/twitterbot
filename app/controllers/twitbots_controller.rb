class TwitbotsController < ApplicationController

  def index
    @twitbots = Twitbot.all
  end

  def show
    @twitbot = Twitbot.find(params[:id])
  end

  def new
    @twitbot = Twitbot.new
  end

  def edit
    @twitbot =Twitbot.find (params[:id])
  end
  def create
    @user = current_user
    @twitbot = @user.twitbots.build(twitbot_params)

    if @twitbot.save
    redirect_to @twitbot
    else
      render 'new'
    end
  end

  def update
    @twitbot = Twitbot.find(params[:id])

    if @twitbot.update(twitbot_params)
      redirect_to @twitbot
    else
      render 'edit'
    end
  end

  def destroy
    @twitbot = Twitbot.find(params[:id])
    @twitbot.destroy

    redirect_to twitbots_path
  end



    private
      def twitbot_params
        params.require(:twitbot).permit(:title, :notes)
      end

end
