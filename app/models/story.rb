class Story < ActiveRecord::Base

	# lets make the code know that there's a relationship
	# between story and comment
	has_many :comments

	# another relationship between story and votes
	has_many :votes


	# lets make sure our data in our database
	# is exactly what we want it to be
	# there is around 10 or 11 types of validations
	validates :title, presence: true, length: { minimum: 5, message: "must be over 5 characters long"}
	validates :link, presence: true, uniqueness: true

	# validates() is a method

	# :title is asymbol because it doesn't
	# change within the code

	# { presence: true } is a hash

end
# this is a representation of our db