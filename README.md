

## Ruby Version
3.0

## Rails Version
 6.1
 
## dependency
Mysql

## Setup
 update database.yml
 
 rake db:create
 
 rake db:migrate
 
 rake db:seed
 
 
## Rspec Testing
run rspec in the root directory


 
 
 ## issues that I noticed
 
 Parameter Sanitization was not done
 
 render was used in the loop
 
 Bank account type enum was using same value 1 for both checking and saving
 
 scope methods were called on individual object which should be called on collection
 
 transfer to saving account was doing opposite. what that mean is instead of deducting from checking and crediting to saving it was doing reverse
 
 there was no model validation
 
 there was no transactional query
 
 Active record does not support composite primary key out of the box
 
 

