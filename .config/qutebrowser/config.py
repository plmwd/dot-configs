config.load_autoconfig()
bind = config.bind

#########################################
#                Bindings               #
#########################################
# Movement
bind('<Alt-j>', 'repeat 5 scroll down')
bind('<Alt-k>', 'repeat 5 scroll up')
bind('<Alt-h>', 'repeat 5 scroll left')
bind('<Alt-l>', 'repeat 5 scroll right')

# Tabs
bind('<Ctrl-o>', 'open -t')
bind('gm', 'tab-move +')
bind('gn', 'tab-move -')

# Sessions
bind('sl', 'session-load')
bind('ss', 'session-save')
bind('sd', 'session-delete')

#########################################
#                Settings                #
#########################################
c.content.javascript.can_access_clipboard = True

c.downloads.remove_finished = 10000
c.downloads.location.suggestion = 'both'
