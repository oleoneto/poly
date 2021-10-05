document.addEventListener('turbo:load', () => {
  document.querySelectorAll('article')
    .forEach((article) => {
      article.querySelectorAll('pre')
        .forEach((block) => {
          // => Desireable structure
          // <div id="code" class="code-sample">
          //     <button class="copy">Copy</button>
          //     <pre class="hljs erb"></pre>
          // </div>

          if (block.previousSibling.tagName === 'BUTTON') return;

          const sample = document.createElement('div')
          sample.classList.add('code-sample', 'my-3')
          sample.insertAdjacentHTML('afterbegin', '<button class="copy z-4"></button>')
        
          block.replaceWith(sample)
        
          sample.insertAdjacentElement('beforeend', block)
        })
  })
});
