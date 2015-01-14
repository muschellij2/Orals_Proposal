# Automatic Intracerebral Hemorrhage Segmentation of CT Scans
John Muschelli  
January 13, 2015  

## Outline of the Talk

* General Neuroimaging / CT Data
* Problem: Manual Segmentation of Intracerebral Hemorrhage
* Proposed Solution / Results
* Future Work








## CT Scanning
<div class="notes">
Images are acquired from an X-ray scanner.  Essentially a an x-ray goes around in a circle or revolves around an objects and passes in x-rays and a detector on the other side of the object to text how many x-rays are recovered.
</div>
<div style="width:48%;float:left;">
![inline fill](figure/CT_diagram2.gif)
<br>
<sub><sup><sub><sup>Image from http://www.cyberphysics.co.uk/topics/medical/CTScanner.htm</sup></sub></sup></sub>
</div>
<div style="margin-left:48%;">
![inline fill](figure/Healthy_Brain_labeled.png)
</div>


## Image Representation: voxels (3D pixels)
<div class="columns-2">
![inline fill](figure/Zoom_No_ICH.png)
![inline fill](figure/movie_final.gif)
</div>





## CT scan Characteristics {.flexbox .vcenter}
<div class="notes">
- This is an example of a CT scan of a brain with no pathology
- Note the bone
An attenuation coefficient characterizes how easily the X-ray beam penetrated that area of the brain.
</div>

<div class="columns-2">
![inline fill](figure/Healthy_Brain_labeled.png)
<sub><sup>http://www.osirix-viewer.com/datasets/</sup></sub>


* Data are in Hounsfield Units (HU), which are "standardized"
$$
HU(v) = 1000 \times \frac{\mu(v) - \mu_{\text{water}}}{ \mu_{\text{water}}- \mu_{\text{air}}}
$$
where $\mu$ is the linear attenuation coefficient and $v$ denotes voxel.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

</div>

## CT scan Characteristics {.flexbox .vcenter}
<div class="notes">
- Here are the intensity ranges for stuff
</div>

<div class="columns-2">
![inline fill](figure/Healthy_Brain_labeled.png)

Ranges for Tissues:

* Bone – high intensity (1000 HU)
* Air – low intensity (-1000 HU)
* Water - 0 HU
* Blood 30-80 HU
* White/Gray Matter ≈ 0 - 100 HU
</div>



## What is Intracranial hemorrhage?

<div class="columns-2">
 - When a blood vessel ruptures into 
    + tissue: intracerebral hemorrhage (ICH)
    + ventricles: intraventricular hemorrhage (IVH)
 - ≈ 13% of strokes    

![](figure/stroke_hem_web.jpg)

<sub><sup>http://www.heartandstroke.com/site/c.ikIQLcMWJtE/b.3484153/k.7675/Stroke__Hemorrhagic_stroke.htm</sup></sub>

</div>






## Demographics of Patients
<div style="float:right;width:500px">
![inline fill](figure/Table1.png)


</div>

<div style="margin-right:500px;">
Data from the MISTIE (Minimally Invasive Surgery plus rt-PA for ICH Evacuation) trial.

- Patients with ICH at presentation
- 112 patients from 112 scans 
</div>

![inline](figure/MISTIE3-LOGO.png)


## CT: Intracerebral Hemorrhage {.flexbox .vcenter}

<div class="columns-2">
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-.png)
</div>


## Intracerebral Hemorrhage: Segmented

<div class="columns-2">
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI.png)

![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI_binary.png)

</div>


## Problems with Manual Segmenation

<div class="columns-2">
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI.png)

* ICH are manually traced (**gold standard**)
  * Time-consuming
  * Within and across-rater variability
* Can't do for large databases
  * Important for some processes, such as image registration
</div>






## **Primary Intracerebral Hemorrhage Prediction Employing Regression and Features Extracted from CT (PItcHPERFECT)** 

$$
\text{logit}\left(Y_{i,j}\right) = \beta_0 + X_{i,j}\beta
$$
for $j$ voxels, $1\dots v_{i}$ for person $i$.  

* Creating predictor variables:
  * Raw intensity
  * Z-scores in all 3 planes with only brain image (skull stripped)
  * Indicator if intensity **$\geq 40$** (established threshold) & $\leq 80$ HU
  * Local moments (mean, sd, skew, kurtosis)
  * Large smoothers
* Run a **logistic regression** with these
* Model built on 10 subjects




## Example Output: 
 
<img src="figure/SS_Image_PrePredict.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">

## Example Output: Manual Segmentation
 
<img src="figure/SS_Image_PrePredict_ROI.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">


## Example Output: Automatic Segmentation
 
<img src="figure/SS_Image_PrePredict_Auto.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">

## Prediction Comparison
 
<img src="figure/Prediction_Figure.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">


## Prediction Result: Population
 
<img src="figure/Modeling_Training_AUC_Rigid_sinc_zval2_Final.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">


## Conclusions and Extensions
 
* ICH Segmentation has high specificity
  * Good for Localization
  * OK for volume estimates
  * Good enough for adaptive randomization


## Thanks

Main Collaborators

<div class="columns-2">
<center><table>
<tr>
<td><img src="Hanley.jpg" style="width:150px; height:100px;" alt="Demog"></td>
<td><img src="Ciprian.jpg" style="width:100px; height:125px;" alt="Demog"></td>
</tr>
</table></center>



<center><table>
<tr>
<img src="Ullman.jpg" style="width:125px; height:125px;" alt="Demog">
<img src="Sweeney.jpg" style="width:125px; height:125px;" alt="Demog">
</tr> 
</table></center>


* Groups

<center><table>
<tr> <td><img src="SMART.png" style="width:200px; height:100px;" alt="Demog"></td> <td> <img src="BIOS.png" style="width:200px; height:100px;" alt="Demog"></td>
</tr>
</table></center>

* Funding

<center><table>
<tr> <td>T32AG000247</td><td> NIA </td></tr>
<tr> <td>RO1EB012547</td><td> NIBIB</td> </tr>
<tr> <td>R01NS046309, RO1NS060910, RO1NS085211, R01NS046309, U01NS080824 and U01NS062851</td> <td>NINDS</td> </tr>
<tr><td>RO1MH095836</td> <td> NIMH </td></tr>
</table></center>

</div>





