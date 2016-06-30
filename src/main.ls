Module = require('module')
path = require('path')

# Methods container
module.exports = rs = {}

# Overrided require shortcut
overrided = Module.prototype.require

# User defined spaces
spaces = {}

# Main function (as global "new" require)
Module.prototype.require = rs.require = (id) ->
   sp = id.match(/^(\w+)::/)

   if sp?
      if spaces[sp[1]]?
         space = spaces[sp[1]]
         route = id.substring(sp[0].length).replace(/^[\/\\]/, '')

         route = path.resolve(space.rel, route)

         if route.indexOf(space.abs) is -1
            throw Error("For security reasons, the final path cannot be an ancestor of the chosen space ('#{sp[1]}': '#{space.abs}').")

         return overrided(route)
      else
         console.warn("Space '#{sp[1]}' for required '#{id}' is not defined.")

   return overrided(id)

# Setup function
rs.config = (obj) !->
   for key, space of obj
      try
         spaces[key] =
            rel: space
            abs: path.resolve(space)
      catch
         throw Error("Absolute path to space '#{key}': '#{space}' cannot be resolved. Detailed message:\n " + e.message)

   return rs
