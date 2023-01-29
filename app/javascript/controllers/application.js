import { Application } from "@hotwired/stimulus"

const application = Application.start()
//Stimulus.register("hi", HiController)

//import { Dropdown } from "tailwindcss-stimulus-components"

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

//application.register('dropdown', Dropdown)

export { application }
