# encrypt/decrypt
alias gpe="gpg --symmetric --batch --passphrase-file $GPG_PASS_FILE"
alias gpd="gpg --decrypt --batch --passphrase-file $GPG_PASS_FILE"

# config
alias gpc="gpgconf"
alias gpca="gpgconf --list-options gpg-agent"

# gpg agent
alias gpas="gpgconf --launch gpg-agent" # start agent - normally not needed as gpg starts the agent automatically
alias gpat="gpg-agent --gpgconf-test" # test gpg agent config
alias gpak="gpgconf --kill gpg-agent" # kill agent

# list
alias gpl="gpg --list-keys"
alias gpls="gpg --list-secret-keys --keyid-format=long"

# export
alias gpx="gpg --export --armor"
alias gpxs="gpg --export-secret-keys --armor"
