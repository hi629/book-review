class BooksController < ApplicationController
    before_action :find_book, only:[:show, :edit, :update, :destroy]

    def index
        if params[:category].blank?
            @books = Book.all.order('created_at DESC') # 新しい順に上から並べるだけ
        else
            @category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(:category_id => @category_id).order("created_at DESC")
        end
    end

    def show
        # before_actionに記述
        # @book = Book.find(params[:id])
        if @book.reviews.blank?
            @average_review = 0
        else
            @average_review = @book.reviews.average(:rating).round(2)
        end
    end

    def new
        @book = current_user.books.build 
        # ドロップダウンメニューで使うselect_tagを作成するとき、カテゴリ名とidが必要
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def create
        @book = current_user.books.build(book_params)
        # params[:category_id]はsubmitボタンを押したときに返ってくる値
        @book.category_id = params[:category_id]
        if @book.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit # 更新内容を表示するとき
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def update # 更新内容を反映させるとき
        @book_category_id = params[:category_id]
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
        # ユーザーが入力したりする箇所。カテゴリIDもユーザーによって更新される
        params.require(:book).permit(:title, :description, :author, :category_id, :book_image)
    end

    def find_book
        # params[:id]は新しく作成したときに自動で作成されるid番号
        @book = Book.find(params[:id])
    end

end
