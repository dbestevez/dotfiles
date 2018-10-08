vol() {
    volume=$(((65536 * $1 + 99) / 100))

    pacmd set-sink-volume $SINK $volume
}
