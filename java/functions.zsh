gradle() {
    if [ -x ./gradlew ]
    then
        ./gradlew "$@"
    else
        ~/.dotfiles/bin/gradle "$@"
    fi
}
