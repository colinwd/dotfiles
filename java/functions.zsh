gradle() {
    if [ -x ./gradlew ]
    then
        echo "found wrapper"
        ./gradlew "$@"
    else
        echo "using global"
        ~/bin/gradle
    fi
}
