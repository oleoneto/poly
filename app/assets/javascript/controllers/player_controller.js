import { Controller } from "stimulus"
import numeral from "numeral"

export default class extends Controller {
    static targets = [
        "bookmark",
        "duration",
        "elapsedTime",
        "audio",
        "progress",
    ]

    connect() {
        const player = document.getElementById("podcast-player");

        this.player = this['audioTarget'];
        this.player.onloadedmetadata = () => {
            this['durationTarget'].innerText = numeral(this.player.duration).format("00:00:00");
        }
        this['elapsedTimeTarget'].innerText = '00:00:00';
    }

    play() {
        if (this.player.paused) {
            this.player.play();
        } else {
            this.player.pause();
        }

        this.player.ontimeupdate = () => {
            const t = (this.player.currentTime / this.player.duration) * 100;
            this['progressTarget'].setAttribute('style', `width: ${t}%;`);
            this['elapsedTimeTarget'].innerText = numeral(this.player.currentTime).format("00:00:00");
        }
    }

    bookmark() {
        // TODO: Implement method
        this['bookmarkTarget'].setAttribute('fill', '#FFF');
        // this['bookmarkTarget'].classList.toggle('bg-yellow-400');
    }

    rewind() {
        // TODO: Implement method
    }

    forward() {
        // TODO: Implement method
    }

    changeSpeed() {
        // TODO: Implement method
    }
}
