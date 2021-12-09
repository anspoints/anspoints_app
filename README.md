# anspoints_app

Ruby version 
> 3.0.2

Dependencies
> Docker

## Build Instructions

Download the required Docker container:
<code>docker pull dmartinez05/ruby_rails_postgresql:latest</code>

Make a directory called ANSPoints wherever you like & move into it:
<code>mkdir ANSPoints; cd ANSPoints</code>

Clone this repository:
<code>git clone https://github.com/anspoints/anspoints_app.git</code>

### Mount and run the Docker image

For Mac:
<code>docker run --rm -it --volume "$(pwd):/ANSPoints" -e DATABASE_USER=anspoints_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest</code>

For Windows:
<code>docker run --rm -it --volume "${PWD}:/ANSPoints" -e DATABASE_USER=anspoints_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest</code>

If you accidentally quit:
<code>docker exec -it "container-name" bash</code>

In the Docker image, create the database:
<code>rails db:create</code>

Migrate the database:
<code>rails db:migrate</code>

Run the server:
<code>rails s --binding=0.0.0.0</code>

### Deploy Code to Heroku

First make sure all your code changes are pushed and updated to the test and main branch.

Now sign in to your heroku dashboard or create an account if needed

Click the "New button" in the top right and select "Create new pipeline"

Fill in the Pppeline name, owner, and search for the github repo you are using to connect the pipeline to.

Now you should a new pipline in front you, under the Review App section Click "Enable Review Apps" and dont select any options

Click “New app” in Review Apps. Choose the test branch. After you click “Create”, Heroku will start deploying immediately. Every time you make changes to the test branch, it triggers automatic deployment.

We also need to create an app for staging. So click under the staging box "Create new app"

Now click on the new staging app and click Deploy using the main branch for Automatic Deploys.

Congrats you now have a deployment pipeling up and running that will update after any new push to the repo.

### CI/CD Setup and Process

To set up the CI/CD Process we are going to use Github actions

First create a new file at the root of the app with the follwing location
<code>/.github/workflows/workflow.yml</code>

Next copy the workflow.yml file from this repo into your newly created file in your repo
<code>https://github.com/dmartinez05/book_collection_solution/blob/main/.github/workflows/workflow.yml</code>

Now commit and push the changes to github

With this commit everytime you make any changes and push them, github actions will run all our Rspec, RuboCop and Brakeman tests to verfiy the new changes they pass. Then with our automatic heroku deployment set up in the previous section you will see a live update of the app.

**Development Notes**
Avoid using scaffolding as it creates extra files & may produce unanticipated side-effects

**Test Site**
https://anspoints-test-app.herokuapp.com/

**Production Site**
https://anspoints.herokuapp.com/

## User Manual
https://anspoints.herokuapp.com/User-Manual

## Admin Manual (Maintenance, Deployment, Instructions, etc.)
https://github.com/anspoints/anspoints_app/wiki/Admin-Manual
