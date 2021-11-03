import "./trix/plugins"
import "./highlight"
import "./name-that-color"
import "@rails/actiontext"

import { Application } from "@hotwired/stimulus"
window.Stimulus = Application.start()

import AccordionController from "./controllers/accordion_controller"
import AttachmentBlockerController from "./controllers/attachment_blocker_controller"
import AudioScannerController from "./controllers/audio_scanner_controller"
import AutocompleteController from "./controllers/autocomplete_controller"
import ColorController from "./controllers/color_controller"
import ClipboardController from "./controllers/clipboard_controller"
import DynamicSelectController from "./controllers/dynamic_select_controller"
import MenuController from "./controllers/menu_controller"
import OfflineController from "./controllers/offline_controller"
import ReactiveTextController from "./controllers/reactive_text_controller"
import SearchController from "./controllers/search_controller"
import SessionController from "./controllers/session_controller"
import PlayerController from "./controllers/player_controller"
import TextCounterController from "./controllers/text_counter_controller"
import ThemeController from "./controllers/theme_controller"
import WaveformController from "./controllers/waveform_controller"

Stimulus.register("accordion", AccordionController)
Stimulus.register("attachment-blocker", AttachmentBlockerController)
Stimulus.register("audio-scanner", AudioScannerController)
Stimulus.register("autocomplete", AutocompleteController)
Stimulus.register("color", ColorController)
Stimulus.register("clipboard", ClipboardController)
Stimulus.register("dyno", DynamicSelectController)
Stimulus.register("menu", MenuController)
Stimulus.register("offline", OfflineController)
Stimulus.register("reactive-text", ReactiveTextController)
Stimulus.register("search", SearchController)
Stimulus.register("session", SessionController)
Stimulus.register("player", PlayerController)
Stimulus.register("text-counter", TextCounterController)
Stimulus.register("theme", ThemeController)
Stimulus.register("waveform", WaveformController)
