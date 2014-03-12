class VotesController < ApplicationController

	# I only need a create method because
	# I don't need a form for the user to fill in
	# either I vote or I don't

	def create
		# find story we want to vote on
		@story = Story.find(params[:story_id])

		# make a new vote on that story with the users ip address
		@vote = @story.votes.new(ip_address: request.ip)

		# save the vote if we haven't voted before
		if @vote.save
			
			# let the user know
			flash[:success] = "You've upvoted this story"

		else
			# let the user know they can't vote twice
			flash[:error] = "You can't vote twice"
		end



		# go back to the story page
		redirect_to story_path(@story)

	end

end
