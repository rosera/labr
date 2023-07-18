# LABR

A quick lab development environment.

- [x] Oh My Bash
- [x] Vim
- [x] Tmux
- [x] git
- [x] taskn
- [ ] v2r
- [x] ownr
- [x] claat

## User Configuration
A development account has been added.

| Field | Environment Variable | Default |
|-------|-------|--------|
| account | $USER_ACCOUNT | ide-dev |
| home    | /home/$USER_ACCOUNT | /home/ide-dev |
| shell   | $USER_SHELL | /bin/bash |


## GIT Configuration

The git configuration is as follows:

| Field | Environment Variable | Default |
|-------|-------|--------|
| user.name | $GIT_NAME | tester |
| user.email | $GIT_EMAIL | tester@gmail.com |
| user.editor | $GIT_EDITOR | vim |


## Local Build

```
docker build -t labr .
```

## Google Cloud Build

```
gcloud builds submit --config cloudbuild.yaml
```


## Run Container

To run with the default values
```
docker run -it labr
```

To substitute the environment variables use the following format

The example below uses the Linux [pass](https://www.passwordstore.org/) command to retrieve the github password
Substitute this command for whatever password manager is being used.

```
docker run --rm -it -e GIT_NAME=${NAME} -e GIT_EMAIL=${EMAIL} -e GIT_PASSWORD=${TOKEN} labr
```

If `OAUTH` required - add network host. Note this doesnt work from Cloud Shell, unless a proxy is used
```
docker run --rm -it --net=host -e GIT_NAME=${NAME} -e GIT_EMAIL=${EMAIL} -e GIT_PASSWORD=${TOKEN} labr
```

To substitute with an environment file

1. Create an environment file `labr-env`
```
GIT_NAME=lab-architects
GIT_EMAIL=lab-architects@google.com
GIT_PASSWORD=secret*password
```


2. Run the command referencing the `lab-env` environment file
```
docker run -it --env-file labr-env labr
```

3. Clone the Repo
```
git clone https://$GIT_NAME:$GIT_PASSWORD@$GIT_REPO
```
