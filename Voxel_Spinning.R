## Isosurfaces of a brain With WebGL
## Splitting function courtesy of Duncan Murdoch
## Open in Safari - make sure Developer -> Enable WebGL clicked
## Should also open in Chrome (Firefox has initialization problem)
## Can comment out datadir/outdir 
## Clear the workspace - rm(list=ls())


require(rgl) # for rendering
require(misc3d) # for contours
### writeWebGL_split - has add on for splitting triangles to maximum number of vertices
### use writeIt = FALSE for knitr - just splits up triangles
outdir = "~/Oral_Proposal/figure"
pngname = file.path(outdir, "centered_voxel.png")
outfname = file.path(outdir, "voxel_figure")

png(pngname, res = 600, height=7, width =7, units = "in")
par(mar=c(0, 0, 0, 0), oma = c(0, 0, 0, 0))
plot(0, 0 ,type="n", 
     xlim = c(0, 3), ylim = c(0,3), axes = FALSE,  xlab="", ylab="")
eg = expand.grid(x0=0:3, x1=0:3, y0=0:3, y1=0:3)
eg = eg[ eg$x0 == eg$x1 | eg$y0 == eg$y1, ]
for (ie in seq(nrow(eg))){
  segments(x0 = eg$x0[ie], 
           y0 = eg$y0[ie], 
           x1 = eg$x1[ie], 
           y1 = eg$y1[ie])
}
rect(xleft = 1, xright = 2, ybottom = 1, ytop = 2, col="black")
dev.off()

open3d()


shade3d(cube3d())

eg = expand.grid(c(-2, 0, 2), c(-2, 0, 2), c(-2, 0, 2))
for (i in seq(nrow(eg))){
  wire3d(translate3d(cube3d(), eg[i,1], eg[i,2], eg[i,3]))
#   wire3d(translate3d(cube3d(), 0, i, 0))
#   wire3d(translate3d(cube3d(), 0, 0, i))
#   wire3d(translate3d(cube3d(), i, i, i))
#   wire3d(translate3d(cube3d(), 0, i, i))
#   wire3d(translate3d(cube3d(), i, i, 0))
#   wire3d(translate3d(cube3d(), i, 0, i))
# 
# 
#   wire3d(translate3d(cube3d(), -i, 0, 0))
#   wire3d(translate3d(cube3d(), 0, -i, 0))
#   wire3d(translate3d(cube3d(), 0, 0, -i))
#   wire3d(translate3d(cube3d(), -i, -i, -i))
#   wire3d(translate3d(cube3d(), 0, -i, -i))
#   wire3d(translate3d(cube3d(), -i, -i, 0))
#   wire3d(translate3d(cube3d(), -i, 0, -i))
}

movie3d( spin3d(), duration = 6, movie = "voxel_figure", dir = outdir)

