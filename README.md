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
