alias pyclean="find . -name '*.pyc' -delete"

clipboard() {
    cat ${1} | xclip -i -selection clipboard
}
