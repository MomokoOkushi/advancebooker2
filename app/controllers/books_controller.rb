class BooksController < ApplicationController
before_action :authenticate_user!
before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
    @book_comment = BookComment.new
    @book_detail = Book.find(params[:id])
    
    #閲覧数カウントbook.rbにて定義済
    unless ReadCount.find_by(user_id:current_user.id, book_id: @book_detail.id)
      current_user.read_counts.create(book_id: @book_detail.id)
    end
    unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, book_id: @book.id)
      current_user.read_counts.create(book_id: @book.id)
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created a book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated a book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    book = Book.find(params[:id])
    if book.user == current_user
    else
      redirect_to books_path
    end
  end
end
