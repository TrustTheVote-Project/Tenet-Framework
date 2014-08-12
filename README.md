Common Services Framework
=========================

An application framework for applications that are offered as Web-delivered multi-tenant services.
Multi-tenant means that the service is offered to multiple distinct organizations, each of which
has a separate instance of the service in a separate sandbox.

The simple sample application exists to demonstrate the documented points of interaction between
the CSF and the application, in way that is simple to see, and easy to replace with connection
points to set of real application software.

The key features of this CSF are:

* CSF administration of each tenant
* tenant administration of its users and roles
* user authentication
* administrator authentication
* use of existing common GEMS for user management, authentication, and user role-based access control
* use of a new technique for strong authentication of administrators using a lightweight closed
  public-key infrastructure that is managed by the CSF-administrator.

The latter feature is the main innovative aspect of CSF, but the value entire framework is as much
in the integration of the innovation with the full set of features, to enable the development of
multi-tenant applications in which administration cannot be compromised by successful attack on
re-usable passwords.


Requirements
------------

* Redis 2.6.16 or later



Installation
------------

Add the gem to the Gemfile:

    gem "csf"

Run bundle install:

    $ bundle install

Create configuration:

    $ bin/rails generate csf:install

Run migrations:

    $ bin/rake db:migrations

Update frame work configuration at `config/csf_config.yml`.

Seed data:

    $ bin/rake csf:db:seed

Rename your `ApplicationController` to `BaseController` (or whatever). `ApplicationController` is provided by CSF and you need to inherit from it to get access to helpers and use layouts, like this:

    class BaseController < ApplicationController
      # your former ApplicationController contents
    end

Don't forget to update other controllers to use your new `BaseController` if you have any.


Auth methods and helpers
------------------------

Here's the collection of methods that can be used in the user / group admin visible parts:

*Filters*:

* require_login - either group admin or user
* require_user_acc - user account is required
* require_admin_acc - group admin account is required

*Helpers*:

* current_user and current_login - either group admin / user `User` instance or `nil`
* current_user_acc - user `User` instance or nil (if not logged in, or logged as admin)
* current_admin_acc - group admin `User` instance or nil (if not logged in, or logged as user)
* group_admin? - TRUE if logged in as group admin


For admin admin parts there is:

*Filters*:

* auth - authenticates the user as admin

*Helpers*:

* admin_admin? - TRUE if the user is logged in as admin admin



Customizing header links
------------------------

Header links for public part are looked up at `app/views/layouts/public/_header_links`. Place a template in your app
there, and it will replace the default logout link.

Admin-admin header links are looked for at `app/views/layouts/admin/_header_links`.



Customizing footer links
------------------------

Footer links can be updated in `config/locales/layouts.en.yml`.




Integrating
-----------

To integrate into publicly visible part you don't do anything special. You create controllers, actions
and views as usual, and use filters / helpers for proper authentication and authorization. If you need
to place a link into header, see the section above.

To integrate into admin part you inherit your controllers from `AdminAdmin::BaseController`. It will give
you proper access control, view layout and helpers.



Localizing
----------

All content of the CSF can be updated through the localization files without altering the code base.
In order to do that, you need to create locale files in `config/locale` folder and override the values
of keys in question. For example, to change the subject of the reset password email, you need to create
a file (or update any existing locale file) and place the following keys in it:

    en:
      notifications:
        reset_password_email:
          subject:
            reset: Your new subject line

You can create any number of locale files to structure your overrides in the most logical way.



App-specific initialization
---------------------------

To initialize your app specifically, you can use Rails initializers. Create a file in the
`config/initializers/` folder and place your custom initialization there. Note that initializers
are loaded in alphabetical order, and so if you need any config settings initialized for your script
name your scripts properly.


Group-specific initialization
-----------------------------

Upon new group creation, when the group is saved, CSF looks for the `GroupInit` class and calls
`perform(Account)` on it if the class and method are present. It gives you a hook to initialize the
newly created group account.


One-time passwords (OTP)
------------------------

Admin-admin and group-admin users log into the system using only OTP.
For this purpose they are providing public keys during their account
registration. When backend saves their account into the database, it
also places the public key into the `authorized_keys` file of the "otp"
unix user account. After that the user can make a connection to this
account with their SSH client or the OTP password app and get the
password in the response. This password is associated with their account
and can be used once, and only for the limited period of time. When the
password expires or is used, to login again, the user needs to request
another OTP.

For the operation of the OTP feature:

  - create "otp" user account with home folder at `/home/otp` and shell
    at `/home/deploy/my-app/current/scripts/otp-generate`
  - touch `~otp/.hushlogin` to prevent MOTD on session start
  - create empty `~otp/.ssh/authorized_keys` file
  - set permissions of the `authorized_keys` file to 400
  - create `~otp/.ssh/environment` and set permissions to 600:

        CSF_DB_USERNAME=<your app db username>
        CSF_DB_NAME=<your app db name>

  - set `~otp/.ssh` and contents ownership to `otp:otp`
  - add the rule to the `/etc/sudoers` that allows `deploy` user to run
    the `<app_root>/scripts/otp_keys` script that works with the keys file

        deploy ALL=(otp) NOPASSWD: /home/deploy/my-app/current/scripts/otp-keys

  - add permissions line to `pg_hba.conf` (PostgreSQL access
    configuration) so that your app database is accessible to the db
    user from CLI. See CSF_DB_USERNAME and CSF_DB_NAME above.

        local <database> <username> trust

