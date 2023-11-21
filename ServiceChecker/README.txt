--------------------------Intro-------------------------------

Hey there, thanks for using my little script. Let me know what you think. This is one of my first scripts, and is relatively simple.

This script may take some tweaking to get it to work just right in your environment. Feel free to change whatever you'd like.


--------------------------How To-------------------------------

To use the Service monitor script, you will need to first set up the services.csv properly.

To do so, list out the server that the target service is on, and then the name of the service. 
Note: this is not the display name that you see most often while working with services, but rather the actual name of the service.

The services.csv should already have headers, and should look like this:
Server,Service


To add the specific services that you would like to check, add them like so:
ExampleServer, ExampleService


The end result should look like:
Server,Service,
ExampleServer, ExampleService


The script will iterate through this CSV, ping the server, and check the status of this service. If the server doesn't ping or doesn't exist, the script will continue to run but will skip the service checking.
