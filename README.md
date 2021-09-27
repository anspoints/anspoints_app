# anspoints_app

Ruby version 
> 3.0.2

Dependencies
> Docker

**Build Instructions**

Download the required docker container
<code>docker pull dmartinez05/ruby_rails_postgresql:latest</code>

Make a directory called ANSPoints wherever you like & move into it
<code>mkdir ANSPoints; cd ANSPoints</code>

Clone this repository
<code>git clone https://github.com/anspoints/anspoints_app.git</code>

Mount & Run the Docker image

For mac:
<code>docker run --rm -it --volume "$(pwd):/ANSPoints" -e DATABASE_USER=anspoints_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest</code>

For windows:
<code>docker run --rm -it --volume "${PWD}:/ANSPoints" -e DATABASE_USER=anspoints_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest</code>

In the docker image, create the database
<code>rails db:create</code>

Migrate the database
<code>rails db:migrate</code>

Run the server
<code>rails s --binding=0.0.0.0</code>

**Development Notes**
Avoid using scaffolding as it creates extra files & may produce unanticipated side-effects

**Test Site**


**Production Site**

