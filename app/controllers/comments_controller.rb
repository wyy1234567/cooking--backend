class CommentsController < ApplicationController
    # create
    # update
    # delete

    def create
        comment = Comment.create(comment_params)
        render json: comment, except: [:created_at, :updated_at]
    end

    def update
        comment = Comment.find(params[:id])
        comment.update(comment_params)
        render json: comment, except: [:created_at, :updated_at]
    end

    def destroy 
        comment = Comment.find(params[:id])
        comment.destroy
    end

    private
    def comment_params
        params.require(:comment).permit(:user_id, :recipe_id, :text)
    end

end

