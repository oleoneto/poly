import { Controller } from "stimulus"
import Tribute from "tributejs";
import Trix from "trix"

export default class extends Controller {
    static targets = [ "field" ]

    connect() {
        this.editor = this["fieldTarget"].editor
        this.initializeTribute()
    }

    disconnect() {
        this.tribute.detach(this["fieldTarget"])
    }

    initializeTribute() {
        this.tribute = new Tribute({
            allowSpaces: true,
            lookup: 'name',
            values: this.fetchData,
        })
        this.tribute.attach((this.fieldTarget))
        this.tribute.range.pasteHtml = this._pasteHtml.bind(this)
        this["fieldTarget"].addEventListener("tribute-replaced", this.replaced)
    }

    fetchData(value, callback) {
        fetch(`/mentions.json?query=${value}`)
            .then(response => response.json())
            .then(data => callback(data))
            .catch(error => callback([]))
    }

    replaced(event) {
        let mention = event.detail.item.original
        let attachment = new Trix.Attachment({
            sgid: mention.sgid,
            content: mention.content
        })
        this.editor.insertAttachment(attachment)
        this.editor.insertString(" ")
    }

    _pasteHtml(html, startPosition, endPosition) {
        // TODO: Fix delete behavior
        // Now, when an attachment is added, any previously inserted text is replace. This behavior is a bug.
        let position = this.editor.getPosition()
        this.editor.setSelectedRange([position - endPosition, position])
        this.editor.deleteInDirection("backward")
    }
}
