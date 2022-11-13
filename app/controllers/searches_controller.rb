class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		elsif @model == 'book'
			@records = Book.search_for(@content, @method)
		elsif @model == 'tag'
			@records = Tag.search_books_for(@content, @method)
	 	end
	end
end




# class SearchesController < ApplicationController
#   def search
#     @model = params[:model]
#     #binding.pry
#     @content = params[:content]
#     @method = params[:method]
#     @records = search_for(@model, @content, @method,@tag)
#     @tag=params[:tag]
#   end

#   private
#   def search_for(model, content, method,tag)
#     if model == 'user'
#       if method == 'perfect'
#         User.where(name: content)
#       else
#         User.where('name LIKE ?', '%'+content+'%')
#       end
#     elsif model == 'book'
#       if method == 'perfect'
#         Book.where(title: content)
#       else
#         Book.where('title LIKE ?', '%'+content+'%')
#       end
#     end
#   end
# end

# def seach_for(tag)
# Book.where(tag: content)
# end