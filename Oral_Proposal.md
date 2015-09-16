# Automated Intracerebral Hemorrhage Segmentation of CT Scans
John Muschelli  
January 13, 2015  



<script type="text/x-mathjax-config">
  MathJax.Hub.Config({ TeX: { extensions: ["color.js"] }});
</script>















## What is Intracranial hemorrhage?

<div class="columns-2" style='font-size: 28pt;'>
 - When a blood vessel ruptures into 
    + tissue: intracerebral hemorrhage (ICH)
    + ventricles: intraventricular hemorrhage (IVH)
 - ≈ 13% of strokes    

![](figure/stroke_hem_web.jpg)

<sub><sup>http://www.heartandstroke.com/site/c.ikIQLcMWJtE/b.3484153/k.7675/Stroke__Hemorrhagic_stroke.htm</sup></sub>

</div>



# Larger ICH Volume ⇒ Worse Outcome



<div style="font-size: 10pt; color:white;" id = 'botval-content'>
J. P. Broderick, T. G. Brott, J. E. Duldner, et al. **"Volume of intracerebral hemorrhage. A powerful and easy-to-use predictor of 30-day mortality."** In: _Stroke_ 24.7 (1993), pp. 987-993.

S. Davis, J. Broderick, M. Hennerici, et al. **"Hematoma growth is a determinant of mortality and poor outcome after intracerebral hemorrhage"**. In: _Neurology_ 66.8 (2006), pp. 1175-1181.

L. C. Jordan, J. T. Kleinman and A. E. Hillis. **"Intracerebral hemorrhage volume predicts poor neurologic outcome in children"**. In:
_Stroke_ 40.5 (2009), pp. 1666-1671.

S. Tuhrim, D. R. Horowitz, M. Sacher, et al. **"Volume of ventricular blood is an important determinant of outcome in supratentorial intracerebral hemorrhage"**. In: _Critical care medicine_ 27.3 (1999),
pp. 617-621.
</div>

## X-ray Computed Tomography (CT) Scans
<div class="notes">
Images are acquired from an X-ray scanner.  
x-ray goes around object and detector the other side of the object determines how many x-rays are recovered 
- fancy transform
- Image!
</div>
<div style="width:48%;float:left;">
![inline fill](figure/CT_diagram2.gif)
<br>
<sub><sup><sub><sup>Image from http://www.cyberphysics.co.uk/topics/medical/CTScanner.htm</sup></sub></sup></sub>
</div>
<div style="margin-left:48%;">
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-.png)
</div>



## CT scan Characteristics
<div class="notes">
- This is an example of a CT scan of a brain with no pathology
- Note the bone
An attenuation coefficient characterizes how easily the X-ray beam penetrated that area of the brain.
</div>

<div class="columns-2"  style='font-size: 22pt;'>
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-.png)

* Data are in Hounsfield Units (HU), which are "standardized"
$$
HU(v) = 1000 \times \frac{\mu(v) - \mu_{\text{water}}}{ \mu_{\text{water}}- \mu_{\text{air}}}
$$
where $\mu$ is the linear attenuation coefficient and $v$ denotes voxel.
* $\mu_{\text{water}}$ and $\mu_{\text{air}}$ are calibrations from each scanner.
</div>


## CT scan Characteristics 
<div class="notes">
- Here are the HU ranges for stuff
</div>

<div class="columns-2" style='font-size: 25pt;'>
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-.png)

Standard HU Ranges:

* Bone – high intensity (1000 HU)
* Air – low intensity (-1000 HU)
* Water - 0 HU
* Blood 30-80 HU
* White/Gray Matter ≈ 0 - 100 HU
</div>


## Get ICH Mask from Manual Segmentation

<div class="columns-2">
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI.png)

![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI_binary.png)

</div>


## Problems with Manual Segmentation

<div class="columns-2" style='font-size: 25pt;'>
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI.png)

* Manual tracing is the **gold standard** but:
    + Time-consuming
    + Requires training
    + Has within- and across-rater variability
* Infeasible for large databases
</div>





## Solution: PItcHPERFECT {.flexbox .vcenter}

<div style='font-size: 35pt;'>
<b>P</b>rimary <br>**I**n**t**ra**c**erebral<br> **H**emorrhage<br> **P**rediction<br> **E**mploying<br> **R**egression and<br> **F**eatures<br> **E**xtracted from<br> **CT** 
</div>


## Covariates <img src="figure/Covariates2.png" style="width:550px; display: block; margin: auto;" alt="MISTIE LOGO">

## PItcHPERFECT uses Logistic Regression
Let $y_{i,j}$ be the presence / absence of ICH for voxel $j$ from person $i$.
$$
\text{logit}\left(y_{i, j}\right) = \beta_0 + \sum_{k= 1}^{p} x_{i, j, k}\beta_{k}
$$

* Case-control sample voxels for a fixed percentage (25%) of outcome
  <img src="figure/Breakdown.png" style="width:650px;height:250px;display: block; margin: auto;">
  


<!--
* Based on the scans from the first 10 patients (non-random)
  + Fit logistic model, predict on non-training data, derive probability cutoff
-->
<!--
where the $x$'s are: 
<div style="width:45%;float: left;">

 1. Voxel intensity: $HU_{i,j}$
 2. Local moments (mean, sd, skew, kurtosis) of $HU_{i,j}$ 
 3-5. Stanardardized intensity: $\frac{HU_{i,j} - \mu_{i}}{\sigma_i}$
 6. Distance of voxel $j$ from brain center
 </div>
 <div style="margin-left:48%;">
 
 7-8. $I\left(HU_{i,j} \geq 40\, \&\, HU_{i,j} \leq 80\right)$ and local mean
<br>
 9-10. Gaussian-smoothed image $(\sigma \in \{10, 20\}\text{mm})$
 <br>
  11.  Standardized intensity to a template: $\frac{HU_{i,j} - \mu_{i, temp}}{\sigma_{i, temp}}$

</div>
-->

## Data Used: 112 scans (1 per patient)
<div style="float:right;width:500px;">


|                 &nbsp;                  |   Overall   |
|:---------------------------------------:|:-----------:|
|           **Age (Mean (SD))**           | 60.7 (11.2) |
|          **Gender = Male (%)**          |  77 (68.8)  |
|  **Diagnostic ICH Volume (Mean (SD))**  | 37.7 (20.2) |
|  **Diagnostic IVH Volume (Mean (SD))**  |  3.2 (6.3)  |
</div>
<div style="margin-right:500px;font-size: 30pt;">
CT scans from MISTIE II trial. 
![inline](figure/MISTIE3-LOGO.png)


</div>


## Assessing Performance 
For each validation scan we can calculate the following 2-by-2 table, where the cells represent number of voxels and a corresponding Venn diagram:

<div style="width:45%;float: left;">


<table class = 'rmdtable' style='font-size: 26px;'>
<tr class = "header"><td></td><td></td><td colspan="2">Manual</td></tr>
<tr class = "header"><td></td><td></td><td>0</td><td>1</td></tr>
<tr><td rowspan="2"> PitCH</td><td>0</td><td style='font-size: 40px;'>TN</td><td style="color:blue">FN</td></tr>
<tr><td>1</td><td style="color:red">FP</td><td style="color:purple">TP</td></tr>
</table>
</div>

<div style="margin-left:48%;">
<img src="figure/Venn_Diagram_labeled.png" style="width:325px;height:325px;display: block; margin: auto;border:5px solid black"">
</div>

## Dice Similarity

<div style="width:48%;float:left;">
We calculate the Dice Similarity Index (DSI):
$$
\definecolor{red}{RGB}{255,0,0}
\definecolor{blue}{RGB}{0,0,255}
\definecolor{purple}{RGB}{128,0,128}
\definecolor{blac,}{RGB}{0,0,0}
\frac{ \color{purple} 2 \times \#  \text{TP} }{ \color{purple}  2 \times \#\text{TP} \color{black} + \color{red} \text{FN} \color{black} + \color{blue} \text{FP}} 
$$

- 0 indicates no overlap
- 1 means perfect agreement  
</div>

<div style="margin-left:48%;">

<img src="figure/Fraction_Figure.png" style="width:400px;height:460px;display: block; margin: auto;">

</div>


## Test case: Manual Segmentation
 
<img src="figure/SS_Image_PrePredict_ROI.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">


## Example Output: Automatic Segmentation
 
<img src="figure/SS_Image_PrePredict_Auto.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">

## Prediction Comparison: DSI: 0.90


<img src="figure/Prediction_Figure.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">


## <img src="figure/Modeling_Training_Dice_Rigid_zval2_Smooth_Final.png" style="width:600px;  display: block; margin: auto;" alt="MISTIE LOGO">


# Thanks




## Prediction Comparison: DSI: 0.686

<img src="figure/Prediction_Figure_303.png" style="width:500px;  display: block; margin: auto;">


## Image Representation: voxels (3D pixels)
<div class="columns-2">
![inline fill](figure/Zoom_No_ICH.png)
![inline fill](figure/movie_final.gif)
</div>

## <img src="figure/Modeling_Training_BA_Volume_Plot_Rigid_zval2_Smooth_Final.png" style="width:600px;  display: block; margin: auto;" alt="MISTIE LOGO">

