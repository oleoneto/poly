import highlightJs from 'highlight.js'
import 'highlight.js/styles/androidstudio.css'

highlightJs.configure({
    languages: [
        'bash',
        'css',
        'erb',
        'html',
        'javascript',
        'python',
        'ruby',
        'swift',
        'typescript',
    ]
});

highlightJs.highlightAll();

document.addEventListener('turbo:load', () => {
    document.querySelectorAll('pre')
        .forEach((block) => {
            highlightJs.highlightBlock(block)
        })
});
