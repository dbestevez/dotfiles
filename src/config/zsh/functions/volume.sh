vol() {
    sinks=$(pacmd list-sinks | grep index | sed -e "s/.*index:\s\+//g")
    volume=$(((65536 * $1 + 99) / 100))

    for sink in $(echo $sinks); do
        pacmd set-sink-volume $sink $volume
    done
}
