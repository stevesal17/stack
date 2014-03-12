class StoriesController < ApplicationController

	# to add a page to my site
	# lets add the index page (aka the home page)
	def index
		# in here lives all the code for the index page
		@username = "tim"

		# to make a list we use square brackets
		# @stories = ["Google", "Facebook", "Twitter", "LinkedIn"]

		# so now we want to get our data from the database
		# order by the most voted then if same, latest first
		# @stories = Story.order("votes_count desc, created_at desc")

		# if the URL has extra params, mainly sort equals recent
		# then order by created_at desc
		# if the fliter equals featured, then just get the 
		# is_featured true stories
		# else just do the usual stuff

		if params[:sort] == "recent"
			# double equals means compare two things together
			# sort by most recent
			@stories = Story.order("created_at desc")

		elsif params[:filter] == "featured"

			# just get the featured ones, ordered by title
			@stories = Story.where(is_featured: true).order("title asc") 

		else
			# sort by most voted
			@stories = Story.order("votes_count desc, created_at desc")
		end


		# render "stories" --> can send to different page rather than default index page
		
	end

	# show me an individual story page
	def show
		# params[:id] is from the URL, eg if /stories/7
		# then params[:id] is 7
		@story = Story.find(params[:id])

	end

	# this is going to be the "adding a new story form" page
	def new
		# make a story be a blank story, ready to be filled in
		@story = Story.new
	end

	# new and create work together as a pair
	# the create action actually adds things to the database
	def create

		# make @story be a blank story but with fields filled in
		@story = Story.new(story_params)

		# save this story to the database IF the validations pass
		# id they don't pass show the form with errors
		if @story.save



			# lets add a notification to our user to let them know it
			# has been saved to the database
			flash[:success] = "Yay, you've submitted a story"

			#  lets make this go back to the home page
			redirect_to root_path
		else
			# if the story doesn't save, do this
			# show the new.html.erb form with errors
			render "new"
		end

	end

	# i want to show the edit from for an induvidual story
	def edit
		# lets find the story based on the url
		@story = Story.find(params[:id])
	end

	# I want to update the database witht eh updated data
	def update
		@story = Story.find(params[:id])

		# update the record with the form data IF VALIDATES
		if @story.update(story_params)

			# let user know
			flash[:success] = "Yay, you've updated the story"

			# lets make this go back to the story page
			redirect_to story_path(@story)
		else
			# if it doesn't update, show the edit form with errors
			render "edit"
		end
		
	end

	# lets destroy this story
	def destroy
		@story = Story.find(params[:id])

		@story.destroy

		# let user know
		flash[:success] = "Yay, you've deleted the story"

		redirect_to root_path
		
	end

	# I want to get the right data from the form
	def story_params
		# only get the title, description and link from the story params
		params.require(:story).permit(:title, :description, :link)

	end

end
