class LikesController < ApplicationController

def create
    @like = current_user.likes.new(like_params)
end


def destroy

end

private
def like_params

end

end
