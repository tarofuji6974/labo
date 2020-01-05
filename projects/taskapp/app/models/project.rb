class Project < ActiveRecord::Base
  # validation処理
  validates :title,
  presence: {message: "入力してください"},
  length: {minimum: 3 , message:"タイトルが短すぎです。"}
end
