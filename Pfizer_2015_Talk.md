# PItcHPERFECT: Primary Intracerebral Hemorrhage Prediction Employing Regression and Features Extracted from CT
John Muschelli, in collaboration with Elizabeth Sweeney, Daniel Hanley, and Ciprian Crainiceanu  
September 17, 2015  
  
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({ TeX: { extensions: ["color.js"] }});
</script>
  





## Neuroimaging Experience

<div class="columns-2">
- At Johns Hopkins (JHU) for 8 years
- ScM Degree in Biostatistics in 2010 (JHU)
- Consultant at JHU Consulting Center
  - Stroke clinical trial - 6 years
    - Reproducible Reports - 3 years
    - CT Imaging Analysis - 4 years
  - fMRI lab - 2 years

<img src="figure/bloomberg.logo.large.vertical.blue.pdf"  style="width:100%;  display: block; margin: auto;">
</div>

## Writing Reproducible Software and Analyses

All analyses/figures/slides were written in [`R`](https://cran.r-project.org/).

R Packages:

- fslr
- WhiteStripe
- brainR
- drammsr
- extrantsr
- dcm2niir
- matlabr
- spm12r

## Stroke Trial Data

* Intracerebral (bleeds mainly in tissue, <strong>ICH</strong>) or Intraventricular (bleeds into ventricles, <strong>IVH</strong>) Hemorrhage trials

* Minimally Invasive Surgery plus rt-PA for ICH Evacuation (<strong>MISTIE</strong>) 
 - multi-center, multi-national Phase II clinical trial

<img src="figure/MISTIE3-LOGO.png" style="width:200px; height:100px; display: block; margin: auto;" alt="MISTIE LOGO">

* http://braininjuryoutcomes.com/mistie-about

## What is Intracranial/Intracerebral hemorrhage?

<div class="columns-2" style='font-size: 28pt;'>
  - When a blood vessel ruptures into 
+ tissue: intracerebral hemorrhage (ICH)
+ ventricles: intraventricular hemorrhage (IVH)
- ≈ 13% of strokes

![](figure/stroke_hem_web.jpg)

<a href = "http://www.heartandstroke.com/site/c.ikIQLcMWJtE/b.3484153/k.7675/Stroke__Hemorrhagic_stroke.htm" style ="font-size:10.5px" >http://www.heartandstroke.com/site/c.ikIQLcMWJtE/b.3484153/k.7675/Stroke__Hemorrhagic_stroke.htm</a>
  
</div>


# Larger ICH Volume ⇒ Worse Outcome


<br>
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
<img src="figure/Original_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">
</div>


## Image Representation: voxels (3D pixels)
<div class="columns-2">
<img src="figure/Zoom_No_ICH.png"  style="width:100%;  display: block; margin: auto;">
<br>
<img src="figure/movie_final.gif" style="width:100%;  inline; display: block; margin: auto;">

</div>


## CT scan Characteristics
<div class="notes">
- This is an example of a CT scan of a brain with no pathology
- Note the bone
An attenuation coefficient characterizes how easily the X-ray beam penetrated that area of the brain.
</div>

<div class="columns-2"  style='font-size: 22pt;'>
<img src="figure/Original_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">


* Voxel Intensities are in Hounsfield Units (HU), which are "standardized"
$$
HU(v) = 1000 \times \frac{\mu(v) - \mu_{\text{water}}}{ \mu_{\text{water}}- \mu_{\text{air}}}
$$
where $\mu$ is the linear attenuation coefficient and $v$ denotes voxel.
* $\mu_{\text{water}}$ and $\mu_{\text{air}}$ are calibrated from each scanner.
</div>


## CT scan Characteristics 
<div class="notes">
- Here are the HU ranges for stuff
</div>

<div class="columns-2" style='font-size: 25pt;'>
<img src="figure/Original_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">

Standard HU Ranges:

* Bone – high intensity (1000 HU)
* Air – low intensity (-1000 HU)
* Water - 0 HU
* Blood 30-80 HU
* White/Gray Matter ≈ 0 - 100 HU
</div>



## CT is NOT MRI (specifically not T1/T2)


-------------------------------------------------------------
    &nbsp;                 CT                     MRI        
-------------- -------------------------- -------------------
  **Domain**           Diagnostic         Diagnostic/Research

  **Units**        Houndsfield Units           Arbitrary     

 **Template**         *One* exists           MNI Standard    

 **Measures**  Measures humans/rooms/beds   Measures Humans  

 **Methods**             Sparse                  Many        
-------------------------------------------------------------

## CT scan Characteristics: Measures Human + Room + FOV

<img src="figure/the_room.png" style="width:100%; display: block; margin: auto;" alt="The room">




## Overall Goal 

<div class="columns-2">

Want to go from this
<img src="figure/Original_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">

To This:
<img src="figure/SS_Image_PrePredict_ROI_Mask.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">
</div>

## ICH Prediction - Training data

* ICH are manually traced (**gold standard**)

<img src="figure/SS_Image_PrePredict_ROI.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">

## Problems with Manual Segmentation

* ICH are manually traced (**gold standard**)
  * Time-consuming
  * Within and across-rater variability
* Not feasible for for large databases
* Hard to use for enrollment criteria (adaptive randomization)


## Subjects and Demographics



## Step 1: CT Skull Stripping

Muschelli, John, et al. "Validated automatic brain extraction of head CT images." NeuroImage 114 (2015): 379-385.

<div class="columns-2">
Want to go from this
<img src="figure/Original_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">

To This:
<img src="figure/SS_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">
</div>


## CT Skull Stripping: Step 1 - Threshold

<div class="columns-2">

Threshold 0- 100 HU:
<img src="figure/Original_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">

Result:
<img src="figure/Thresh_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">
</div>


## CT Skull Stripping: Step 2 - Smooth

<div class="columns-2">

Smooth Image with 1mm Gaussian
<img src="figure/Thresh_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">
<br>
Result:
<img src="figure/Smooth_Thresh_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">

</div>

## CT Skull Stripping: Step 3 - Run BET

<div class="columns-2">

Run Brain Extraction Tool from FSL:
<img src="figure/Smooth_Thresh_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">
<br>
Result (Skull Stripped Image):
<img src="figure/SS_Image.png" style="width:100%;  display: block; margin: auto;" alt="MISTIE LOGO">

</div>


## Covariates <img src="figure/Covariates2.png" style="width:550px;  display: block; margin: auto;" alt="MISTIE LOGO">  

## PItcHPERFECT uses Logistic Regression
  Let $y_{i}(v)$ be the presence / absence of ICH for voxel $v$ from person $i$.
$$
  \text{logit}\left(y_{i}(v)\right) = \beta_0 + \sum_{k= 1}^{p} x_{i, k}(v)\beta_{k}
$$
  
  * Case-control sample voxels for a fixed percentage (25%) of outcome
<img src="figure/Breakdown.png" style="width:650px;height:250px;display: block; margin: auto;">
  



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


## Get ICH Mask from Manual Segmentation
  
![inline fill](figure/Figure_DSI_Quantile_000.png)

</div>


## Test case: Manual Segmentation
 
<img src="figure/SS_Image_PrePredict_ROI.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">


## Example Output: Automatic Segmentation
 
<img src="figure/SS_Image_PrePredict_Auto.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">

## Prediction Comparison: DSI: 0.90


<img src="figure/Prediction_Figure.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">


## <img src="figure/Modeling_Training_Dice_Rigid_zval2_Smooth_Final.png" style="width:600px;  display: block; margin: auto;" alt="MISTIE LOGO">

## Prediction Comparison: DSI: 0.90



<img src="figure/Prediction_Figure.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">



# Thanks


## Other Projects {#nextsteps}

<div class="columns-2">

- Segmentation of Gadolinium-Enhancing Lesions in Patients with MS on MRI
<br/>
- Segmentation of Ischemic Stroke Lesions (ISLES MICCAI Grand Challenge)
</br>
- Association of Longitudinal Intracerebral Hemorrhage Location and Functional Outcomes
- Visualization of 3D and 4D Images




## Statistics Philosophy and Goals

1. "How does that compare to the mean?" - Ciprian Crainiceanu

2. The goal is to solve problems.  Statistics is one tool.  Given all available options, choose the simplest and/or fastest solution.

3. Never trust the data is clean

4. You never do anything once. 

