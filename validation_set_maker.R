# Importing libraries
library(rgdal)
library(raster)
library(ggplot2)
library(gridExtra)

# Inputs
city = 'biasca'
xmin = 2714000 
xmax = 2720000
ymin = 1134500 
ymax = 1140500
  
# Signing years
y1 <- 1970
y2 <- 1977
y3 <- 1983
y4 <- 1989
y5 <- 1995
y6 <- 2001
y7 <- 2006
y8 <- 2012
y9 <- 2016
#y10<- 2004
ym<- 2018

# Importing dataset
pts <- readOGR('/home/huriel/Documents/swisstopo/regbl/biasca_regbl_pts.shp')

# Gathering a set of buildings with agreeing construction date in both RegBL and swisstopo maps for new validation metric
## get only data with construction dates
sum(is.na(pts$GBAUJ))
length(pts)
pts <- pts[!is.na(pts$GBAUJ),]
length(pts)

## calling the raster
setwd('/media/huriel/Seagate Expansion Drive1/regbl_maps/poc_base/biasca/')
r1 <- biasca_1970 <- raster('LKG25_LV95_1273_1970_1.tif')
r2 <- biasca_1977 <- raster('LKG25_LV95_1273_1977_1.tif')
r3 <- biasca_1983 <- raster('LKG25_LV95_1273_1983_1.tif')
r4 <- biasca_1989 <- raster('LKG25_LV95_1273_1989_1.tif')
r5 <- biasca_1995 <- raster('PK25_LV95_KGRS_1273_1995_1.tif')
r6 <- biasca_2001 <- raster('PK25_LV95_KGRS_1273_1995_1.tif')
r7 <- biasca_2006 <- raster('PK25_LV95_KGRS_1273_2006_1.tif')
r8 <- biasca_2012 <- raster('SMR25_LV95_KGRS_1273_2012_1.tif')
r9 <- biasca_2016 <- raster('SMR25_LV95_SITU_1273_2016_1.tif')
r10 <-biasca_2018 <- raster('SMR25_LV95_KGRS_1273_2012_1.tif')

# extract data from swisstopo map
coords_ca <- pts@coords
ext_r1 <- extract(r1, coords_ca)
pts$r1 <- ext_r1
ext_r2 <- extract(r2, coords_ca)
pts$r2 <- ext_r2
ext_r3 <- extract(r3, coords_ca)
pts$r3 <- ext_r3
ext_r4 <- extract(r4, coords_ca)
pts$r4 <- ext_r4
ext_r5 <- extract(r5, coords_ca)
pts$r5 <- ext_r5
ext_r6 <- extract(r6, coords_ca)
pts$r6 <- ext_r6
ext_r7 <- extract(r7, coords_ca)
pts$r7 <- ext_r7
ext_r8 <- extract(r8, coords_ca)
pts$r8 <- ext_r8
ext_r9 <- extract(r9, coords_ca)
pts$r9 <- ext_r9
ext_r10 <- extract(r10, coords_ca)
pts$r10 <- ext_r10
ext_r11 <- extract(r11, coords_ca)
pts$r11 <- ext_r11

# get only black coloured pixels - houses
pts$year <- as.numeric(pts$GBAUJ)
pts$r1 <- ifelse(pts$r1 < 40, 1, 0)
pts$r2 <- ifelse(pts$r2 < 50, 1, 0)
pts$r3 <- ifelse(pts$r3 < 40, 1, 0)
pts$r4 <- ifelse(pts$r4 < 40, 1, 0)
pts$r5 <- ifelse(pts$r5 < 4, 1, 0)
pts$r6 <- ifelse(pts$r6 < 4, 1, 0)
pts$r7 <- ifelse(pts$r7 < 4, 1, 0)
pts$r8 <- ifelse(pts$r8 < 31, 1, 0)
#pts$r9 <- ifelse(pts$r9 < 4, 1, 0)
pts$r10 <- ifelse(pts$r10 < 31, 1, 0)
pts <- pts[!is.na(pts$r1),]
summary(pts)

# Identifying year of construction caslano on swisstopo map
pts$year_map <- ifelse(pts$r1 == 1, y1, 0 )
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 == 1, y2, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 == 1, y3, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 == 1, y4, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 != 1 & pts$r5 == 1, y5, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 != 1 & pts$r5 != 1 & pts$r6 == 1, y6, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 != 1 & pts$r5 != 1 & pts$r6 != 1 & pts$r7 == 1, y7, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 != 1 & pts$r5 != 1 & pts$r6 != 1 & pts$r7 != 1 & pts$r8 == 1, y8, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 != 1 & pts$r5 != 1 & pts$r6 != 1 & pts$r7 != 1 & pts$r8 != 1 & pts$r9 == 1, 
                        y9, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 != 1 & pts$r5 != 1 & pts$r6 != 1 & pts$r7 != 1 & pts$r8 != 1 & pts$r9 != 1 &
                        y10 == 1, y10, pts$year_map)
pts$year_map <- ifelse (pts$r1 != 1 & pts$r2 != 1 & pts$r3 != 1 & pts$r4 != 1 & pts$r5 != 1 & pts$r6 != 1 & pts$r7 != 1 & pts$r8 != 1 & pts$r9 != 1 &
                          y10 != 1 & ymax == 1, ym, pts$year_map)
summary(pts$year_map)

# create gaps based on maps
pts$gap_map <- ifelse(pts$year_map >= y1 & pts$year_map < y2, 1, 0 ) 
pts$gap_map <- ifelse(pts$year_map >= y2 & pts$year_map < y3, 2, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y3 & pts$year_map < y4, 3, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y4 & pts$year_map < y5, 4, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y5 & pts$year_map < y6, 5, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y6 & pts$year_map < y7, 6, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y7 & pts$year_map < y8, 7, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y8 & pts$year_map < y9, 8, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y9 & pts$year_map < y10, 9, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map >= y10 & pts$year_map < ym, 10, pts$gap_map )
pts$gap_map <- ifelse(pts$year_map == ym, 11, pts$gap_map )

pts$gap_regbl <- ifelse(pts$year >= y1 & pts$year < y2, 1, 0 ) 
pts$gap_regbl <- ifelse(pts$year >= y2 & pts$year < y3, 2, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y3 & pts$year < y4, 3, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y4 & pts$year < y5, 4, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y5 & pts$year < y6, 5, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y6 & pts$year < y7, 6, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y7 & pts$year < y8, 7, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y8 & pts$year < y9, 8, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y9 & pts$year < y10, 9, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year >= y10 & pts$year < ym, 10, pts$gap_regbl )
pts$gap_regbl <- ifelse(pts$year == ym, 11, pts$gap_regbl )

# divergence in year gaps
pts$dif <- pts$gap_map - pts$gap_regbl
hist(pts$dif, main = 'Difference in the nº of gaps \n between what is found on maps and regbl', xlab = 'difference')

# query for zero difference in year gaps
pts_selec <- pts[which(pts$dif == 0),]
length(pts_selec)

# plot selection
pts_df <- as.data.frame(pts)
p1 <- ggplot() +
  geom_point(data = pts_df, aes(x = GKODE, y = GKODN, color = factor(gap_regbl)), size = 1) +
  scale_fill_brewer(palette="Reds") +
  labs(title = city) + 
  labs(x = "longitude", y = "latitude") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        axis.line = element_blank())

pts_sel_df <- as.data.frame(pts_selec)
p2 <- ggplot() +
  geom_point(data = pts_sel_df, aes(x = GKODE, y = GKODN, color = factor(gap_regbl)),
             size = 0.5) + xlim(range(as.integer(pts$GKODE))) + ylim(range(as.integer(pts$GKODN))) +
  scale_color_grey() + theme_classic() +
  labs(title = city) + 
  labs(x = "longitude", y = "latitude") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        axis.line = element_blank())
grid.arrange(p1, p2)

# select only what's truly usable
sel <- pts_selec[which(pts_selec$GKODE >= xmin & pts_selec$GKODE <= xmax & pts_selec$GKODN >= ymin & pts_selec$GKODN <= ymax),]
sel <- sel[which(sel$year >= y1 & sel$year <= ymax),]
sel <- sel[which(sel$year == sel$year_map),] # You may want to avoid this line if you dont want to be so rough on the selection
nrow(sel)
as.integer(sel$EGID)

write the file
write.table(paste0(sel$EGID, collapse = "\n"), city, row.names = F, col.names = F)





###########################################################################################################
# remove ".jpg" from ls file
t <- read.table('/media/huriel/Seagate Expansion Drive1/regbl_maps/poc_detection/spatiotemporal_biasca/biasca')
t <- gsub(".jpg", "", t[,1])
write.table(paste0(t, collapse = "\n"), 'bia', row.names = F, col.names = F)
length(t)
