# Automated Intracerebral Hemorrhage Segmentation of CT Scans
John Muschelli  
`r Sys.Date()`  
  
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

<a href = "http://www.heartandstroke.com/site/c.ikIQLcMWJtE/b.3484153/k.7675/Stroke__Hemorrhagic_stroke.htm" style ="font-size:10.5px" >http://www.heartandstroke.com/site/c.ikIQLcMWJtE/b.3484153/k.7675/Stroke__Hemorrhagic_stroke.htm</a>
  
</div>
  
## Get ICH Mask from Manual Segmentation
  
<div class="columns-2">
![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI.png)

![inline fill](figure/100-318_20070724_0026_CT_3_CT_Head-ROI_binary.png)

</div>

## Covariates <img src="figure/Covariates2.png" style="width:550px;  display: block; margin: auto;" alt="MISTIE LOGO">  

## PItcHPERFECT uses Logistic Regression
  Let $y_{i,j}$ be the presence / absence of ICH for voxel $j$ from person $i$.
$$
  \text{logit}\left(y_{i, j}\right) = \beta_0 + \sum_{k= 1}^{p} x_{i, j, k}\beta_{k}
$$
  
  * Case-control sample voxels for a fixed percentage (25%) of outcome
<img src="figure/Breakdown.png" style="width:650px;height:250px;display: block; margin: auto;">
  


## <img src="figure/Modeling_Training_Dice_Rigid_zval2_Smooth_Final.png" style="width:600px;  display: block; margin: auto;" alt="MISTIE LOGO">


## Prediction Comparison: DSI: 0.90



<img src="figure/Prediction_Figure.png" style="width:500px;  display: block; margin: auto;" alt="MISTIE LOGO">

# Thanks

