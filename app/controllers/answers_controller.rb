class AnswersController < ApplicationController
  def index

       @answer = Answer.find(params[:id])


    end



  end
end
