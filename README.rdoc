= Common Services Framework

An application framework (including a simple sample application) for applications that are offered as Web-delivered multi-tenant services. Multi-tenant means that the service is offered to multiple distinct organizations, each of which has a separate instance of the service in a separate sandbox. The simple sample application exists to demonstrate the documented points of interaction between the CSF and the application, in way that is simple to see, and easy to replace with connection points to set of real application software. The key featurs of this CSF are: CSF administration of each tenant; tenant administration of its users and roles; user authentication; administrator authentication; use of existing common GEMS for user management, authentication, and user role-based access control; use of a new technique for strong authentication of administrators using a lightweight closed public-key infrastructure that is managed by the CSF-administrator. The latter feature is the main innovative aspect of CSF, but the value entire framework is as much in the integration of the innovation with the full set of features, to enable the development of multi-tenant applications in which administration cannot be compromised by successful attack on re-usable passwords.

= Requirements

* Redis 2.6.16 or later

= Installation

Add the gem to the Gemfile:

    gem "csf"
    
Run bundle install:

    $ bundle install
    
Create configuration:

    $ rails generate csf:install
    
Run migrations:

    $ rake db:migrations
    
Update frame work configuration at `config/csf_config.yml`.
