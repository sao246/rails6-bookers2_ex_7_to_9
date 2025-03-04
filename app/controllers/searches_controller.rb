class SearchesController < ApplicationController
  def search
    query = params[:query]
    method = params[:method]
    category = params[:category]

    if query.blank?
      @books = Book.all
      @users = User.all
      return
    end

    case category
    when "books"
      @books = search_books(query, method)
      @users = []
    when "users"
      @users = search_users(query, method)
      @books = []
    else
      @books = search_books(query, method)
      @users = search_users(query, method)
    end
  end

private
  def search_books(query, method)
    case method
    when "perfect"
      Book.where(title: query)
    when "forward"
      Book.where("title LIKE ?", "#{query}%")
    when "backward"
      Book.where("title LIKE ?", "%#{query}")
    else
      Book.where("title LIKE ?", "%#{query}%")
    end
  end

  def search_users(query, method)
    case method
    when "perfect"
      User.where(name: query)
    when "forward"
      User.where("name LIKE ?", "#{query}%")
    when "backward"
      User.where("name LIKE ?", "%#{query}")
    else
      User.where("name LIKE ?", "%#{query}%")
    end
  end
end
