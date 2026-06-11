// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

const controllers = require.context('.', true, /_controller\.js$/)
controllers.keys().forEach(controllers)
