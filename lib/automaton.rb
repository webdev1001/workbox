require_relative './automaton/workbox.rb'
require_relative './automaton/dropbox_authorization.rb'

folder_structure = ['/a',
                    '/b*',
                  { '/c*' => ['/ca',
                              '/cb*',
                            { '/cc*' => ['/cca',
                                         '/ccb*'] },
                              '/cd',
                              '/ce*'] }, 
                    '/d',
                    '/e']

Workbox.new.create_and_print(folder_structure)
