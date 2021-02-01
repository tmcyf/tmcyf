# No longer maintained

TMCYF.org [![Code Climate](https://codeclimate.com/github/tmcyf/tmcyf.png)](https://codeclimate.com/github/tmcyf/tmcyf) [![Build Status](https://travis-ci.org/tmcyf/tmcyf.png?branch=master)](https://travis-ci.org/tmcyf/tmcyf)
=======

Source for the Trinity Mar Thoma Church Youth Fellowship website.


Guides, workflows, templates, and more information for TMCYF designers and developers can be found in the [documentation](http://tmcyf.github.io/).


## Deployment

Anything in the master branch is deployable. Large changes such as Rails configuration or new features should be deployed to staging server and tested before merging with master.

#### Prereq's

1. Provision server using TMCYF::Skeleton chef repo.
2. Ensure SSH keys exist on server.

Once you can SSH into server as they `deploy` user, you're ready to deploy.

For the first deployment:

run `rake "set_deploy_ip[<stage>, <server ip>]"`

Run `cap <stage> deploy:check` to verify required files and directories exist.

Run `cap <stage> deploy` to deploy via Git and restart processes.

For subsequent deploys, simply run `cap <stage> deploy`.

**Important!**

Since RDS is managing the database, postgresql is not installed on the server. This means before deploying, check in `database.yml` that production values are replaced by staging values. This can be reverted back once deployment is finalized and ready for prime time.
