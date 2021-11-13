import highlightJs from 'highlight.js'

highlightJs.configure({
    languages: [
        'applescript',
        'bash',
        'css',
        'erb',
        'html',
        'javascript',
        'php',
        'python',
        'ruby',
        'swift',
        'typescript',
    ]
})

highlightJs.highlightAll()

function formatBlocks() {
    document.querySelectorAll('pre')
        .forEach((block) => {
            highlightJs.highlightElement(block)
        })
}

function createClipboardCopyButton() {
    document.querySelectorAll('article')
        .forEach((article) => {
            article.querySelectorAll('pre')
                .forEach((block) => {
                    if (block.previousSibling.tagName === 'BUTTON') return;

                    const sample = document.createElement('div')
                    sample.classList.add('code-sample', 'my-3')
                    sample.insertAdjacentHTML('afterbegin', '<button class="copy z-4"></button>')

                    block.replaceWith(sample)

                    sample.insertAdjacentElement('beforeend', block)
                })
        })
}

document.addEventListener('DOMContentLoaded', () => {
    formatBlocks()
    createClipboardCopyButton()
})
