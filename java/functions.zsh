gradle() {
    if [ -x ./gradlew ]
    then
        ./gradlew "$@"
    else
        ~/bin/gradle
    fi
}
