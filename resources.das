options indenting = 2

require daslib/media

var private images: table<string; ImageHandle>

def load_images(description: table<string; string>)
  for name, path in keys(description), values(description)
    images[name] = create_managed_image(path)
  

def get_image(name: string)
  return images[name]
