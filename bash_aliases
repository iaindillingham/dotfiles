alias pyclean="find . -name '*.pyc' -delete"

thumbnail() {
    SRC_FILE_PATH=${1}
    SRC_DIR_PATH=`dirname ${SRC_FILE_PATH}`
    DST_FILE_PATH="${SRC_DIR_PATH}/thumbnail.png"
    convert -scale '230' -crop 'x120+0+0' ${SRC_FILE_PATH} ${DST_FILE_PATH}
}

preview() {
    SRC_FILE_PATH=${1}
    SRC_DIR_PATH=`dirname ${SRC_FILE_PATH}`
    DST_FILE_PATH="${SRC_DIR_PATH}/preview.png"
    convert -scale '960' -crop 'x500+0+0' ${SRC_FILE_PATH} ${DST_FILE_PATH}
}
