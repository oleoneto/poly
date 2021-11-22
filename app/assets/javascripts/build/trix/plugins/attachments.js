window.addEventListener("trix-attachment-add", function (event) {
    let attachment = event.attachment
    let editor = event.target.editor
    let range = editor.getDocument().getRangeOfAttachment(attachment)

    console.log({"event": "trix-attachment-add", "attachmentRange:": range, attachment})
    // attachment.setAttributes({range})
})
