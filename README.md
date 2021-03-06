# zabbix-server-docker
Docker image for the Zabbix server

## Default login

The default login user is "admin", and the password is "zabbix".

## Using the alertscripts

This image comes with custom alert scripts. Unfortunately, configuring
them is a bit messy since we can only pass values in the recipient,
subject or message fields.

To pass config options to the alert script, add a line containing
`--CONFIG JSON--` and then a json object containing the actual config
values to the action message::

    Alert!
    Something went wrong!
    --CONFIG JSON--
    {"foo":"bar"}

### Mandrill

[Mandrill](https://mandrill.com/) is a transactional email service which, unlike
the native email feature in zabbix, lets us securely send email
without using an open relay or a local mail server.

The `mandrill` script takes three options:

* MANDRILL_API_KEY
* MANDRILL_FROM_EMAIL
* MANDRILL_FROM_NAME

### Slack

A script is included for pushing messages to [Slack](https://slack.com/).

The `slack` script takes one option:

* SLACK_WEBHOOK_URL
