class CommentsController < ApplicationController


def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(params_comment)
    redirect_to post_path(@post)
end

def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    if !@comment.destroy
        flash[:notice] = @comment.errors.full_messages.to_sentence
    end
    redirect_to post_path(@post)
end

def params_comment
    params.require(:comment).permit(:comment,:parent_id ,:user_id).with_defaults(user_id: current_user.id)
    
end

end
