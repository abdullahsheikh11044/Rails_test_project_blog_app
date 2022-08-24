class CommentsController < ApplicationController


def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(params_comment)
    redirect_to post_path(@post)
end

def destroy
    @post =Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
end
def params_comment
    params.require(:comment).permit(:name, :comment,:parent_id ,:user_id).with_defaults(user_id: current_user.id)
    
end

end
