"UnrecognizedTags" is not an official Six Apart release, and as such support from Six Apart for this plugin is not available.

The UnrecognizedTags plugin is a tool for identifying all tags in use across all templates system-wide that Movable Type does not recognize.

Movable Type will throw an error message when it encounters an unrecognized tag in the course of rebuilding, or when you edit a template containing one, but this means that in order to identify all such tags you must either open every template or repeatedly rebuild, resolve or <mt:Ignore> the first tag encountered (which will stop the rebuild), and then try rebuilding again.

UnrecognizedTags is intended to simplify this process. It can be especially useful when upgrading, or preparing to use or discontinue use of a particular plugin, or for large or legacy installations all of whose blogs and templates aren't fully understood by the people currently dealing with the system. 

The plugin adds an "Unrecognized Tags" menu item to the Tools menu at the System Overview level. When you select this item, UnrecognizedTags will generate and display a listing of all usages of unrecognized tags, grouped by tag, and listing the blog and template (with a link to edit the template) in which each usage occurs.
