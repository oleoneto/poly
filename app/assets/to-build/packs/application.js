import "./trix/plugins"

import "./highlight"

import { Application } from "@hotwired/stimulus"
window.Stimulus = Application.start()

import AccordionController from "./controllers/accordion_controller"
import AudioScannerController from "./controllers/audio_scanner_controller"
import ColorController from "./controllers/color_controller"
import ClipboardController from "./controllers/clipboard_controller"
import CommentsController from "./controllers/comments_controller"
import MenuController from "./controllers/menu_controller"
import OfflineController from "./controllers/offline_controller"
import ReactiveTextController from "./controllers/reactive_text_controller"
import SearchController from "./controllers/search_controller"
import SessionController from "./controllers/session_controller"
import PlayerController from "./controllers/player_controller"
import ThemeController from "./controllers/theme_controller"
import WaveformController from "./controllers/waveform_controller"

Stimulus.register("accordion", AccordionController)
Stimulus.register("audio_scanner", AudioScannerController)
Stimulus.register("color", ColorController)
Stimulus.register("clipboard", ClipboardController)
Stimulus.register("comments", CommentsController)
Stimulus.register("menu", MenuController)
Stimulus.register("offline", OfflineController)
Stimulus.register("reactive", ReactiveTextController)
Stimulus.register("search", SearchController)
Stimulus.register("session", SessionController)
Stimulus.register("player", PlayerController)
Stimulus.register("theme", ThemeController)
Stimulus.register("waveform", WaveformController)
