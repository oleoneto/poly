import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ "theme", "toggle" ]

    connect() {
        this.theme = localStorage.theme;
        this['themeTarget'].classList.toggle('dark', this.theme === 'dark');
        this['toggleTarget'].classList.toggle('translate-x-full', !this.theme || this.theme === 'light');
    }

    toggleTheme() {
        localStorage.theme = this.theme === 'dark' ? 'light' : 'dark';
        this.theme = localStorage.theme;

        this['themeTarget'].classList.toggle('dark', this.theme === 'dark');
        this['toggleTarget'].classList.toggle('translate-x-full', this.theme === 'light');
    }
}
