% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SAIGE_fitGLMM_fast.R
\name{fitNULLGLMM}
\alias{fitNULLGLMM}
\title{Fit the null logistic/linear mixed model and estimate the variance ratios by randomly selected variants}
\usage{
fitNULLGLMM(plinkFile = "", phenoFile = "", phenoCol = "",
  traitType = "binary", invNormalize = FALSE, covarColList = NULL,
  qCovarCol = NULL, sampleIDColinphenoFile = "", tol = 0.02,
  maxiter = 20, tolPCG = 1e-05, maxiterPCG = 500, nThreads = 1,
  SPAcutoff = 2, numMarkers = 30, skipModelFitting = FALSE,
  memoryChunk = 2, tauInit = c(0, 0), LOCO = FALSE,
  traceCVcutoff = 0.0025, ratioCVcutoff = 0.001, outputPrefix = "",
  outputPrefix_varRatio = NULL, IsSparseKin = FALSE,
  sparseGRMFile = NULL, sparseGRMSampleIDFile = NULL,
  numRandomMarkerforSparseKin = 500, relatednessCutoff = 0.125,
  isCateVarianceRatio = FALSE, cateVarRatioIndexVec = NULL,
  cateVarRatioMinMACVecExclude = c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 10.5,
  20.5), cateVarRatioMaxMACVecInclude = c(1.5, 2.5, 3.5, 4.5, 5.5, 10.5,
  20.5), isCovariateTransform = TRUE, isDiagofKinSetAsOne = FALSE)
}
\arguments{
\item{plinkFile}{character. Path to plink file to be used for calculating elements of the genetic relationship matrix (GRM). Genetic markers are also randomly selected from the plink file to estimate the variance ratios}

\item{phenoFile}{character. Path to the phenotype file. The phenotype file has a header and contains at least two columns. One column is for phentoype and the other column is for sample IDs. Addiitonal columns can be included in the phenotype file for covariates in the null GLMM. Please note covariates to be used in the NULL GLMM need to specified using the argument covarColList.}

\item{phenoCol}{character. Column name for the phenotype in phenoFile e.g. "CAD"}

\item{traitType}{character. e.g. "binary" or "quantitative". By default, "binary"}

\item{invNormalize}{logical. Whether to perform the inverse normalization for the phentoype or not. E.g. TRUE or FALSE. By default, FALSE}

\item{covarColList}{vector of characters. Covariates to be used in the null GLM model e.g c("Sex", "Age")}

\item{qCovarCol}{vector of characters. Categorical covariates to be used in the glm model (NOT work yet)}

\item{sampleIDColinphenoFile}{character.  Column name for the sample IDs in the phenotype file e.g. "IID".}

\item{tol}{numeric.The tolerance for fitting the null GLMMM to converge. By default, 0.02.}

\item{maxiter}{integer. The maximum number of iterations used to fit the null GLMMM. By default, 20.}

\item{tolPCG}{numeric. The tolerance for PCG to converge. By default, 1e-5.}

\item{maxiterPCG}{integer. The maximum number of iterations for PCG. By default, 500.}

\item{nThreads}{integer. Number of threads to be used. By default, 1}

\item{SPAcutoff}{numeric. The cutoff for the deviation of score test statistics from the mean in the unit of sd to perform SPA. By default, 2.}

\item{numMarkers}{integer (>0). Minimum number of markers to be used for estimating the variance ratio. By default, 30}

\item{skipModelFitting}{logical.  Whether to skip fitting the null model and only calculating the variance ratio, By default, FALSE. If TURE, the model file ".rda" is needed}

\item{memoryChunk}{integer or float. The size (Gb) for each memory chunk. By default, 2}

\item{tauInit}{vector of numbers. e.g. c(1,1), Unitial values for tau. For binary traits, the first element will be always be set to 1. If the tauInit is not specified, the second element will be 0.5 for binary traits.}

\item{LOCO}{logical. Whether to apply the leave-one-chromosome-out (LOCO) option.}

\item{traceCVcutoff}{numeric. The threshold for coefficient of variantion (CV) for the trace estimator to increase nrun. By default, 0.0025}

\item{ratioCVcutoff}{numeric. The threshold for coefficient of variantion (CV) for the variance ratio estimate. If ratioCV > ratioCVcutoff. numMarkers will be increased by 10. By default, 0.001}

\item{outputPrefix}{character. Path to the output files with prefix.}

\item{outputPrefix_varRatio}{character. Path to the output variance ratio file with prefix. variace ratios will be output to outputPrefix_varRatio.varianceRatio.txt. If outputPrefix_varRatio is not specified, outputPrefix_varRatio will be the same as the outputPrefix}

\item{IsSparseKin}{logical. Whether to exploit the sparsity of GRM to estimate the variance ratio. By default, TRUE}

\item{sparseGRMFile}{character. Path to the pre-calculated sparse GRM file. If not specified and  IsSparseKin=TRUE, sparse GRM will be computed}

\item{sparseGRMSampleIDFile}{character. Path to the sample ID file for the pre-calculated sparse GRM. No header is included. The order of sample IDs is corresponding to the order of samples in the sparse GRM.}

\item{numRandomMarkerforSparseKin}{integer. number of randomly selected markers (MAF >= 0.01) to be used to identify related samples for sparse GRM. By default, 500}

\item{relatednessCutoff}{float. The threshold to treat two samples as unrelated if IsSparseKin is TRUE. By default, 0.125}

\item{isCateVarianceRatio}{logical. Whether to estimate variance ratio based on different MAC categories. If yes, variance ratio will be estiamted for multiple MAC categories corresponding to cateVarRatioMinMACVecExclude and cateVarRatioMaxMACVecInclude. Currently, if isCateVarianceRatio=TRUE, then LOCO=FALSE. By default=FALSE}

\item{cateVarRatioIndexVec}{vector of integer 0 or 1. The length of cateVarRatioIndexVec is the number of MAC categories for variance ratio estimation. 1 indicates variance ratio in the MAC category is to be estimated, otherwise 0. By default, NULL. If NULL, variance ratios corresponding to all specified MAC categories will be estimated. This argument is only activated when isCateVarianceRatio=TRUE}

\item{cateVarRatioMinMACVecExclude}{vector of float. Lower bound of MAC for MAC categories. The length equals to the number of MAC categories for variance ratio estimation. By default, c(0.5,1.5,2.5,3.5,4.5,5.5,10.5,20.5). This argument is only activated when isCateVarianceRatio=TRUE}

\item{cateVarRatioMaxMACVecInclude}{vector of float. Higher bound of MAC for MAC categories. The length equals to the number of MAC categories for variance ratio estimation minus 1. By default, c(1.5,2.5,3.5,4.5,5.5,10.5,20.5). This argument is only activated when isCateVarianceRatio=TRUE}

\item{isCovariateTransform}{logical. Whether use qr transformation on non-genetic covariates. By default, TRUE}

\item{isDiagofKinSetAsOne}{logical. Whether to set the diagnal elements in GRM to be 1. By default, FALSE}
}
\value{
a file ended with .rda that contains the glmm model information, a file ended with .varianceRatio.txt that contains the variance ratio values, and a file ended with #markers.SPAOut.txt that contains the SPAGMMAT tests results for the markers used for estimating the variance ratio.
}
\description{
Fit the null logistic/linear mixed model and estimate the variance ratios by randomly selected variants
}
