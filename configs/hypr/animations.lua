local animations = {
  {
    leaf = "windows",
    enabled = true,
    speed = 6,
    bezier = "wind",
    style = "slide"
  },
  {
    leaf = "windowsIn",
    enabled = true,
    speed = 6,
    bezier = "winIn",
    style = "slide"
  },
  {
    leaf = "windowsOut",
    enabled = true,
    speed = 5,
    bezier = "winOut",
    style = "slide"
  },
  {
    leaf = "windowsMove",
    enabled = true,
    speed = 5,
    bezier = "wind",
    style = "slide"
  },
  {
    leaf = "border",
    enabled = true,
    speed = 1,
    bezier = "linear",
  },
  {
    leaf = "borderangle",
    enabled = true,
    speed = 30,
    bezier = "linear",
    style = "loop",
  },
  {
    leaf = "fade",
    enabled = true,
    speed = 10,
    bezier = "default",
  },
  {
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "wind",
  }
}

hl.curve("wind", {
  type = "bezier",
  points = {
    { 0.05, 0.9 },
    { 0.1,  1.05 },
  },
})

hl.curve("winIn", {
  type = "bezier",
  points = {
    { 0.1, 1.1 },
    { 0.1, 1.1 },
  },
})

hl.curve("winOut", {
  type = "bezier",
  points = {
    { 0.3, -0.3 },
    { 0,   1 },
  },
})

for _, anim in ipairs(animations) do
  hl.animation(anim)
end