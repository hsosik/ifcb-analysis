import numpy as np

from scipy.ndimage.measurements import find_objects

from skimage.measure import regionprops

from functools import lru_cache

from .segmentation import segment_roi
from .blobs import find_blobs, rotate_blob, blob_shape
from .blob_geometry import (equiv_diameter, ellipse_properties,
                            invmoments, convex_hull, convex_hull_image,
                            convex_hull_properties, feret_diameter,
                            binary_symmetry, feret_diameters)
from .morphology import find_perimeter
from .biovolume import (distmap_volume_surface_area,
                        sor_volume_surface_area)
from .perimeter import perimeter_stats, hausdorff_symmetry
from .texture import statxture, masked_pixels, texture_pixels
from .hog import image_hog
from .ringwedge import ring_wedge, _N_RINGS, _N_WEDGES

class BlobFeatures(object):
    def __init__(self,blob_image,roi_image):
        """roi_image should be the same size as the blob image,
        so a sub-roi"""
        self.image = np.array(blob_image).astype(np.bool)
        self.roi_image = roi_image
    @property
    def shape(self):
        """h,w of blob image"""
        return self.image.shape
    @property
    def bbox_ywidth(self):
        return self.shape[0]
    @property
    def bbox_xwidth(self):
        return self.shape[1]
    @property
    def size(self):
        """h*w of blob image"""
        return self.image.size
    @property
    @lru_cache()
    def regionprops(self):
        """region props of the blob (assumes single connected region)"""
        return regionprops(self.image.astype(np.uint8))[0]
    @property
    @lru_cache()
    def area(self):
        """area of blob"""
        return self.regionprops.area
    @property
    @lru_cache()
    def equiv_diameter(self):
        """equivalent diameter of blob"""
        return self.regionprops.equivalent_diameter
    @property
    @lru_cache()
    def perimeter(self):
        return self.regionprops.perimeter
    @property
    def area_over_perimeter_squared(self):
        return self.area / self.perimeter**2
    @property
    def area_over_perimeter(self):
        return self.area / self.perimeter
    @property
    @lru_cache()
    def extent(self):
        """extent of blob"""
        return self.regionprops.extent
    @property
    @lru_cache()
    def convex_hull(self):
        """vertices of convex hull of blob"""
        return convex_hull(self.perimeter_points)
    @property
    @lru_cache()
    def convex_hull_properties(self):
        return convex_hull_properties(self.convex_hull)
    @property
    @lru_cache()
    def convex_perimeter(self):
        """perimeter of convex hull"""
        perimeter, _ = self.convex_hull_properties
        return perimeter
    @property
    @lru_cache()
    def convex_area(self):
        """area of convex hull"""
        _, area = self.convex_hull_properties
        return area
    @property
    @lru_cache()
    def feret_diameter(self):
        return feret_diameter(self.convex_hull)
    @property
    @lru_cache()
    def _feret_diameters(self):
        return feret_diameters(self.convex_hull)
    @property
    @lru_cache()
    def min_feret_diameter(self):
        return self._feret_diameters[0]
    @property
    @lru_cache()
    def max_feret_diameter(self):
        return self._feret_diameters[1]
    @property
    @lru_cache()
    def convex_hull_image(self):
        """convex hull mask"""
        return self.regionprops.convex_image
    @property
    @lru_cache()
    def ellipse_properties(self):
        # maj_axis, min_axis, ecc, orientation
        return ellipse_properties(self.image)
    @property
    @lru_cache()
    def major_axis_length(self):
        """major axis length of blob"""
        return self.ellipse_properties[0]
    @property
    @lru_cache()
    def minor_axis_length(self):
        """minor axis length of blob"""
        return self.ellipse_properties[1]
    @property
    @lru_cache()
    def eccentricity(self):
        """1st eccentricity of blob"""
        return self.ellipse_properties[2]
    @property
    @lru_cache()
    def orientation(self):
        """return orientation of blob in degrees"""
        return (180/np.pi) * self.regionprops.orientation
    @property
    @lru_cache()
    def centroid(self):
        return self.regionprops.centroid
    @property
    @lru_cache()
    def solidity(self):
        """area / convex area of blob"""
        return float(self.area) / self.convex_area
    @property
    @lru_cache()
    def rotated_image(self):
        """blob rotated so major axis is horizontal. may
        not be touching edges of returned image"""
        return rotate_blob(self.image, self.orientation)
    @property
    @lru_cache()
    def rotated_area(self):
        """area of rotated blob"""
        return np.sum(self.rotated_image)
    @property
    @lru_cache()
    def rotated_shape(self):
        """height, width of rotated image's bounding box"""
        return blob_shape(self.rotated_image)
    @property
    def rotated_bbox_xwidth(self):
        return self.rotated_shape[1]
    @property
    def rotated_bbox_ywidth(self):
        return self.rotated_shape[0]
    @property
    def rotated_bbox_solidity(self):
        return self.rotated_area / \
            float(self.rotated_bbox_xwidth * self.rotated_bbox_ywidth)
    @property
    @lru_cache()
    def perimeter_image(self):
        """perimeter of blob defined via erosion and logical and"""
        return find_perimeter(self.image)
    @property
    @lru_cache()
    def perimeter_points(self):
        """points on the perimeter of the blob"""
        return np.where(self.perimeter_image)
    @property
    @lru_cache()
    def distmap_volume_surface_area(self):
        """volume of blob computed via Moberg & Sosik algorithm"""
        return distmap_volume_surface_area(self.image, self.perimeter_image)
    @property
    @lru_cache()
    def sor_volume_surface_area(self):
        """volume of blob computed via solid of revolution method"""
        return sor_volume_surface_area(self.rotated_image)
    @property
    @lru_cache()
    def biovolume_surface_area(self):
        """biovolume and representative transect computed using
        Moberg & Sosik algorithm"""
        area_ratio = float(self.convex_area) / self.area
        p = self.equiv_diameter / self.major_axis_length
        if area_ratio < 1.2 or (self.eccentricity < 0.8 and p > 0.8):
            return self.sor_volume_surface_area
        else:
            return self.distmap_volume_surface_area
    @property
    @lru_cache()
    def biovolume(self):
        """biovolume computed using Moberg & Sosik algorithm"""
        return self.biovolume_surface_area[0]
    @property
    @lru_cache()
    def representative_width(self):
        """representative width"""
        return self.biovolume_surface_area[1]
    @property
    @lru_cache()
    def surface_area(self):
        return self.biovolume_surface_area[2]
    @property
    @lru_cache()
    def perimeter_stats(self):
        """mean, median, skewness, kurtosis of pairwise distances
        between each pair of perimeter points"""
        return perimeter_stats(self.perimeter_points, self.equiv_diameter)
    @property
    @lru_cache()
    def perimeter_mean(self):
        """mean of pairwise distances between perimeter points"""
        return self.perimeter_stats[0]
    @property
    @lru_cache()
    def perimeter_median(self):
        """median of pairwise distances between perimeter points"""
        return self.perimeter_stats[1]
    @property
    @lru_cache()
    def perimeter_skewness(self):
        """skewness of pairwise distances between perimeter points"""
        return self.perimeter_stats[2]
    @property
    @lru_cache()
    def perimeter_kurtosis(self):
        """kurtosis of pairwise distances between perimeter points"""
        return self.perimeter_stats[3]
    @property
    @lru_cache()
    def hausdorff_symmetry(self):
        """takes the rotated blob perimeter and compares it
        with itself rotated 180 degrees, rotated 90 degrees,
        and mirrored across the major axis, using
        the modified Hausdorff distance between the rotated
        blob perimeter and each of those variants"""
        return hausdorff_symmetry(self.rotated_image)
    @property
    @lru_cache()
    def h180(self):
        return self.hausdorff_symmetry[0]
    @property
    @lru_cache()
    def h90(self):
        return self.hausdorff_symmetry[1]
    @property
    @lru_cache()
    def hflip(self):
        return self.hausdorff_symmetry[2]
    @property
    def h90_over_hflip(self):
        return self.h90 / self.hflip
    @property
    def h90_over_h180(self):
        return self.h90 / self.h180
    @property
    def hflip_over_h180(self):
        return self.hflip / self.h180
    @property
    @lru_cache()
    def binary_symmetry(self):
        return binary_symmetry(self.rotated_image)
    @property
    def b180(self):
        return self.binary_symmetry[0]
    @property
    def b90(self):
        return self.binary_symmetry[1]
    @property
    def bflip(self):
        return self.binary_symmetry[2]
        
class RoiFeatures(object):
    def __init__(self,roi_image, blobs_image=None, raw_stitch=None):
        self.image = np.array(roi_image).astype(np.uint8)
        self.raw_stitch = raw_stitch
        self._blobs_image = None
        if blobs_image is not None:
            self._blobs_image = blobs_image
    @property
    def blobs_image(self):
        """return the mask resulting from segmenting the image using
        the algorithm in ifcb.features.segmentation.segment_roi"""
        if self._blobs_image is None:
            self._blobs_image = segment_roi(self.image, self.raw_stitch)
        return self._blobs_image
    @property
    @lru_cache()
    def blobs(self):
        """returns the BlobFeatures objects representing each of the blobs in
        the segmented mask, ordered by largest area to smallest area"""
        labeled, bboxes, blobs = find_blobs(self.blobs_image)
        cropped_rois = [self.image[bbox] for bbox in bboxes]
        # ignore 1-pixel wide/high blobs
        Bs = [BlobFeatures(b,R) for b,R in zip(blobs,cropped_rois) if min(R.shape) > 1]
        # sort by area, largest first
        return sorted(Bs, key=lambda B: B.area, reverse=True)
    @property
    def num_blobs(self):
        return len(self.blobs)
    @property
    @lru_cache()
    def rotated_blobs_image(self):
        if self.num_blobs == 0:
            return None
        orientation = self.blobs[0].orientation
        return rotate_blob(self.blobs_image, orientation)
    @property
    @lru_cache()
    def hog(self):
        """returns the Histogram of Oriented Gradients of the image.
        see ifcb.features.hog"""
        return image_hog(self.image)
    @property
    @lru_cache()
    def invmoments(self):
        """invariant moments computed using algorithm described in
        Digital Image Processing Using MATLAB, pp. 470-472"""
        if self.num_blobs > 0:
            return invmoments(self.blobs_image)
        else:
            return [0 for _ in range(7)]
    @property
    @lru_cache()
    def texture_pixels(self):
        """all pixel values of the contrast-enhanced image, in the blob,
        as a flat list"""
        return texture_pixels(self.image, self.blobs_image)
    @property
    @lru_cache()
    def texture_stats(self):
        """mean intensity, average contrast, smoothness,
        third moment, uniformity, entropy of texture pixels.
        based on algorithm described in Digital Image Processing Using
        MATLAB, pp . 464-468.
        see texture_pixels"""
        # average_gray_level, average_contrast, smoothness,
        # third_moment, uniformity, entropy
        if self.num_blobs > 0:
            return statxture(self.texture_pixels)
        else:
            return [0 for _ in range(6)]
    @property
    @lru_cache()
    def texture_average_gray_level(self):
        """average gray level of texture pixels"""
        return self.texture_stats[0]
    @property
    @lru_cache()
    def texture_average_contrast(self):
        """average contrast of texture pixels"""
        return self.texture_stats[1]
    @property
    @lru_cache()
    def texture_smoothness(self):
        """smoothness of texture pixels"""
        return self.texture_stats[2]
    @property
    @lru_cache()
    def texture_third_moment(self):
        """third moment of texture pixels"""
        return self.texture_stats[3]
    @property
    @lru_cache()
    def texture_uniformity(self):
        """uniformity of texture pixels"""
        return self.texture_stats[4]
    @property
    @lru_cache()
    def texture_entropy(self):
        """entropy of texture pixels"""
        return self.texture_stats[5]
    @property
    @lru_cache()
    def phi(self,n):
        """nth invariant moment (see invmoments)"""
        return self.invmoments[n-1]
    @property
    @lru_cache()
    def ring_wedge(self):
        if self.num_blobs > 0:
            pwr_integral, pwr_ratio, wedges, rings = ring_wedge(self.blobs_image)
            return pwr_integral, pwr_ratio, wedges, rings
        else:
            return [0, 0, [0 for _ in range(_N_WEDGES)], [0 for _ in range(_N_RINGS)]]
    @property
    @lru_cache()
    def rw_power_integral(self):
        return self.ring_wedge[0]
    @property
    @lru_cache()
    def rw_power_ratio(self):
        return self.ring_wedge[1]
    @property
    @lru_cache()
    def wedge(self):
        return self.ring_wedge[2]
    @property
    @lru_cache()
    def ring(self):
        return self.ring_wedge[3]
    @lru_cache()
    def summed_attr(self, attr):
        return np.sum(getattr(b,attr) for b in self.blobs)
    @property
    def summed_area(self):
        return self.summed_attr('area')
    @property
    def summed_biovolume(self):
        return self.summed_attr('biovolume')
    @property
    def summed_surface_area(self):
        return self.summed_attr('surface_area')
    @property
    def summed_convex_area(self):
        return self.summed_attr('convex_area')
    @property
    def summed_convex_perimeter(self):
        return self.summed_attr('convex_perimeter')
    @property
    def summed_major_axis_length(self):
        return self.summed_attr('major_axis_length')
    @property
    def summed_minor_axis_length(self):
        return self.summed_attr('minor_axis_length')
    @property
    def summed_perimeter(self):
        return self.summed_attr('perimeter')
    @property
    def summed_feret_diameter(self):
        return self.summed_attr('feret_diameter')
    @property
    def summed_convex_perimeter_over_perimeter(self):
        if self.num_blobs > 0:
            return self.summed_convex_perimeter / self.summed_perimeter
        else:
            return 0

def get_multifeature(fmt,vals):
    return [(fmt % (n+1,), v) for n,v in zip(range(len(vals)),vals)]

N_FEATURES=241

class ZeroMock(object):
    def __getattr__(self, name):
        return 0

def compute_features(roi_image, blobs_image=None, raw_stitch=None):
    r = RoiFeatures(roi_image, blobs_image, raw_stitch=raw_stitch)
    if r.num_blobs > 0:
        b = r.blobs[0]
    else:
        b = ZeroMock()
    f = []
    f += [
        ('Area', b.area),
        ('B180', b.b180),
        ('B90', b.b90),
        ('Bflip', b.bflip),
        ('Biovolume', b.biovolume),
        ('BoundingBox_xwidth', b.bbox_xwidth),
        ('BoundingBox_ywidth', b.bbox_ywidth),
        ('ConvexArea', b.convex_area),
        ('ConvexPerimeter', b.convex_perimeter),
        ('Eccentricity', b.eccentricity),
        ('EquivDiameter', b.equiv_diameter),
        ('Extent', b.extent),
        ('H180', b.h180),
        ('H90', b.h90),
        ('Hflip', b.hflip),
        ('MajorAxisLength', b.major_axis_length),
        ('MinorAxisLength', b.minor_axis_length),
        ('Orientation', b.orientation),
        ('Perimeter', b.perimeter),
        ('RWcenter2total_powerratio', r.rw_power_ratio),
        ('RWhalfpowerintegral', r.rw_power_integral),
        ('RepresentativeWidth', b.representative_width),
        ('RotatedBoundingBox_xwidth', b.rotated_bbox_xwidth),
        ('RotatedBoundingBox_ywidth', b.rotated_bbox_ywidth),
        ('Solidity', b.solidity),
        ('SurfaceArea', b.surface_area),
        ('maxFeretDiameter', b.max_feret_diameter),
        ('minFeretDiameter', b.min_feret_diameter)
    ]
    f += get_multifeature('moment_invariant%d', r.invmoments)
    f += [
        ('numBlobs', r.num_blobs),
        ('shapehist_kurtosis_normEqD', b.perimeter_kurtosis),
        ('shapehist_mean_normEqD', b.perimeter_mean),
        ('shapehist_median_normEqD', b.perimeter_median),
        ('shapehist_skewness_normEqD', b.perimeter_skewness),
        ('summedArea', r.summed_area),
        ('summedBiovolume', r.summed_biovolume),
        ('summedConvexArea', r.summed_convex_area),
        ('summedConvexPerimeter', r.summed_convex_perimeter),
        ('summedMajorAxisLength', r.summed_major_axis_length),
        ('summedMinorAxisLength', r.summed_minor_axis_length),
        ('summedPerimeter', r.summed_perimeter),
        ('summedSurfaceArea', r.summed_surface_area),
        ('texture_average_contrast', r.texture_average_contrast),
        ('texture_average_gray_level', r.texture_average_gray_level),
        ('texture_entropy', r.texture_entropy),
        ('texture_smoothness', r.texture_smoothness),
        ('texture_third_moment', r.texture_third_moment),
        ('texture_uniformity', r.texture_uniformity)
    ]
    f += get_multifeature('Wedge%02d', r.wedge)
    f += get_multifeature('Ring%02d', r.ring)
    f += get_multifeature('HOG%02d', r.hog)
    f += [
        ('Area_over_PerimeterSquared', b.area_over_perimeter_squared),
        ('Area_over_Perimeter', b.area_over_perimeter),
        ('H90_over_Hflip', b.h90_over_hflip),
        ('H90_over_H180', b.h90_over_h180),
        ('Hflip_over_H180', b.hflip_over_h180),
        ('summedConvexPerimeter_over_Perimeter', r.summed_convex_perimeter_over_perimeter),
        ('rotated_BoundingBox_solidity', b.rotated_bbox_solidity)
    ]
    return (r.blobs_image, f)
