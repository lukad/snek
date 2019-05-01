function love.conf(t)
  t.window.title = "snek"
  t.window.width = 640
  t.window.height = 480
  t.releases = {
    title = 'Snek',
    package = 'snek',
    loveVersion = '11.2',
    version = '0.1.0',
    author = 'Luka Dornhecker',
    email = 'luka.dornhecker@gmail.com',
    description = 'A snake game',
    homepage = 'https://github.com/lukad/snek',
    identifier = 'me.dornhecker.snek',
    excludeFileList = {},
    compile = true
  }
end
