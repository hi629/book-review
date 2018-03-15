class BooksController < ApplicationController
    before_action :find_book, only:[:show, :edit, :update, :destroy]

    def index
        # 新しい順に上から並べる
        @books = Book.all.order('created_at DESC')
    end

    def show
        # before_actionに記述
        # @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        # ユーザーがコンテンツを編集するときにはbook_params updateされたらshowページへ
        if @book.update(book_params)
            redirect_to book_path(@book)
        else
            render 'edit'
        end
    end

    def destroy
        @book.destroy
        redirect_to root_path
    end

    private

    def book_params
        # ユーザーが入力したりする箇所
        params.require(:book).permit(:title, :description, :author)
    end

    def find_book
        # params[:id]は新しく作成したときに自動で作成されるid番号
        @book = Book.find(params[:id])
    end

end
