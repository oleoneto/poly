import "@rails/actiontext"

import { Application } from "@hotwired/stimulus"
window.Stimulus = Application.start()

import AttachmentBlockerController from "./controllers/attachment_blocker_controller"
import AutocompleteController from "./controllers/autocomplete_controller"
import DynamicSelectController from "./controllers/dynamic_select_controller"
import OfflineController from "./controllers/offline_controller"
import ReactiveTextController from "./controllers/reactive_text_controller"
import TextCounterController from "./controllers/text_counter_controller"
import ThemeController from "./controllers/theme_controller"

Stimulus.register("attachment-blocker", AttachmentBlockerController)
Stimulus.register("autocomplete", AutocompleteController)
Stimulus.register("dynamic-select", DynamicSelectController)
Stimulus.register("offline", OfflineController)
Stimulus.register("reactive-text", ReactiveTextController)
Stimulus.register("text-counter", TextCounterController)
Stimulus.register("theme", ThemeController)
