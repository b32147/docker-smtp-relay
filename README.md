# Postfix Mail Relay

The container provides a simple proxy relay for environments like Amazon VPC where you may have private servers with no Internet connection
and therefore with no access to external mail relays (e.g. Amazon SES, SendGrid and others). You need to supply the container with your 
external mail relay address and credentials. The configuration is tested with Amazon SES.

This container runs under the s6 supervisor. Docker secrets are supported and the instructions for usage are included in the 'Variables' section.

## Running

Run the container with a command similar to the following:

```sh
$ docker run -d -h relay.example.com -e SMTP_LOGIN=<username> -e SMTP_PASSWORD=<password> -p 8025:25 b32147/smtp-relay
```

The container defaults to listening on port `25` but can be set to anything. The above example sets the container on the host's port `8025`.

## Variables

| Variable | Default | Description
| ------ | ------ | ------ |
|`SMTP_LOGIN` | | Login to connect to the external relay (required, otherwise the container fails to start)
|`SMTP_PASSWORD` | | Password to connect to the external relay (required, otherwise the container fails to start)
|`EXT_RELAY_HOST` | `email-smtp.us-east-1.amazonaws.com` | External relay DNS name
|`EXT_RELAY_PORT` | `587` | External relay TCP port
|`USE_TLS` | `yes` | Remote require tls. Might be "yes" or "no"
|`TLS_VERIFY` | `may` | Trust level for checking the remote side cert. (none, may, encrypt, dane, dane-only, fingerprint, verify, secure).
|`HOST_NAME` | `relay.example.com` | A DNS name for this relay container (usually the same as the Docker's hostname)
|`ACCEPTED_NETWORKS` | `172.16.0.0/12 10.0.0.0/8` | A network (or a list of networks) to accept mail from

If using Docker Secrets, format the value of the argument as:

* `SMTP_LOGIN=/run/secrets/smtp-login`

where `smtp-login` is the name of the secret created in Docker. This will read the secret at that location (should be `/run/secrets/`) and assign its contents to the original argument.

