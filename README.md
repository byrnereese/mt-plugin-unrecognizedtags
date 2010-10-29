# Unrecognized Tags plugin

The Unrecognized Tags plugin is a tool for identifying all tags in use across
all templates system-wide that Movable Type does not recognize.

## Overview

This plugin is useful for Movable Type administrators who need to quickly scan
an installation for any and all template tags that are unrecognized by the
system. Unrecognized tags can result from the following:

* Core template tags being removed after first being deprecated.
* Disabling a plugin that provides template tags that templates depend
  upon.
* Deleting a plugin that provides template tags.
* A plugin that is broken for some reason.

The default behavior of Movable Type is to throw an error message when it
encounters an unrecognized tag during the course of a rebuild or when a
template is edited. This means that in order to identify all such tags it is
necessary to open edit and save every template or to repeatedly rebuild. Then
each unrecognized tag must be resolved by hand or wrapped in `<mt:Ignore>`
before trying to rebuild again.

UnrecognizedTags is intended to simplify this process. It can be especially
useful when upgrading, or when preparing to use or discontinue use of a
particular plugin. It is also helpful for large or legacy installations all of
whose blogs and templates aren't fully understood by the people currently
dealing with the system.

## Usage

The plugin adds an "Unrecognized Tags" menu item to the Tools menu at the
System Overview level. When you select this item, UnrecognizedTags will
generate and display a listing of all usages of unrecognized tags, grouped by
tag, and listing the blog and template (with a link to edit the template) in
which each usage occurs.
