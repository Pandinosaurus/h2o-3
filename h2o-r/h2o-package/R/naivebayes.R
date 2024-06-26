# This file is auto-generated by h2o-3/h2o-bindings/bin/gen_R.py
# Copyright 2016 H2O.ai;  Apache License Version 2.0 (see LICENSE for details) 
#
# -------------------------- Naive Bayes Model in H2O -------------------------- #
#'
#' Compute naive Bayes probabilities on an H2O dataset.
#' 
#' The naive Bayes classifier assumes independence between predictor variables conditional
#' on the response, and a Gaussian distribution of numeric predictors with mean and standard
#' deviation computed from the training dataset. When building a naive Bayes classifier,
#' every row in the training dataset that contains at least one NA will be skipped completely.
#' If the test dataset has missing values, then those predictors are omitted in the probability
#' calculation during prediction.
#'
#' @param x (Optional) A vector containing the names or indices of the predictor variables to use in building the model.
#'        If x is missing, then all columns except y are used.
#' @param y The name or column index of the response variable in the data. 
#'        The response must be either a numeric or a categorical/factor variable. 
#'        If the response is numeric, then a regression model will be trained, otherwise it will train a classification model.
#' @param training_frame Id of the training data frame.
#' @param model_id Destination id for this model; auto-generated if not specified.
#' @param nfolds Number of folds for K-fold cross-validation (0 to disable or >= 2). Defaults to 0.
#' @param seed Seed for random numbers (affects certain parts of the algo that are stochastic and those might or might not be enabled by default).
#'        Defaults to -1 (time-based random number).
#' @param fold_assignment Cross-validation fold assignment scheme, if fold_column is not specified. The 'Stratified' option will
#'        stratify the folds based on the response variable, for classification problems. Must be one of: "AUTO",
#'        "Random", "Modulo", "Stratified". Defaults to AUTO.
#' @param fold_column Column with cross-validation fold index assignment per observation.
#' @param keep_cross_validation_models \code{Logical}. Whether to keep the cross-validation models. Defaults to TRUE.
#' @param keep_cross_validation_predictions \code{Logical}. Whether to keep the predictions of the cross-validation models. Defaults to FALSE.
#' @param keep_cross_validation_fold_assignment \code{Logical}. Whether to keep the cross-validation fold assignment. Defaults to FALSE.
#' @param validation_frame Id of the validation data frame.
#' @param ignore_const_cols \code{Logical}. Ignore constant columns. Defaults to TRUE.
#' @param score_each_iteration \code{Logical}. Whether to score during each iteration of model training. Defaults to FALSE.
#' @param balance_classes \code{Logical}. Balance training data class counts via over/under-sampling (for imbalanced data). Defaults to
#'        FALSE.
#' @param class_sampling_factors Desired over/under-sampling ratios per class (in lexicographic order). If not specified, sampling factors will
#'        be automatically computed to obtain class balance during training. Requires balance_classes.
#' @param max_after_balance_size Maximum relative size of the training data after balancing class counts (can be less than 1.0). Requires
#'        balance_classes. Defaults to 5.0.
#' @param laplace Laplace smoothing parameter Defaults to 0.
#' @param threshold This argument is deprecated, use `min_sdev` instead. The minimum standard deviation to use for observations without enough data.
#'        Must be at least 1e-10.
#' @param min_sdev The minimum standard deviation to use for observations without enough data.
#'        Must be at least 1e-10.
#' @param eps This argument is deprecated, use `eps_sdev` instead. A threshold cutoff to deal with numeric instability, must be positive.
#' @param eps_sdev A threshold cutoff to deal with numeric instability, must be positive.
#' @param min_prob Min. probability to use for observations with not enough data.
#' @param eps_prob Cutoff below which probability is replaced with min_prob.
#' @param compute_metrics \code{Logical}. Compute metrics on training data Defaults to TRUE.
#' @param max_runtime_secs Maximum allowed runtime in seconds for model training. Use 0 to disable. Defaults to 0.
#' @param export_checkpoints_dir Automatically export generated models to this directory.
#' @param gainslift_bins Gains/Lift table number of bins. 0 means disabled.. Default value -1 means automatic binning. Defaults to -1.
#' @param auc_type Set default multinomial AUC type. Must be one of: "AUTO", "NONE", "MACRO_OVR", "WEIGHTED_OVR", "MACRO_OVO",
#'        "WEIGHTED_OVO". Defaults to AUTO.
#' @return an object of class \linkS4class{H2OBinomialModel} if the response has two categorical levels,
#'         and \linkS4class{H2OMultinomialModel} otherwise.
#' @examples
#' \dontrun{
#' h2o.init()
#' votes_path <- system.file("extdata", "housevotes.csv", package = "h2o")
#' votes <- h2o.uploadFile(path = votes_path, header = TRUE)
#' h2o.naiveBayes(x = 2:17, y = 1, training_frame = votes, laplace = 3)
#' }
#' @export
h2o.naiveBayes <- function(x,
                           y,
                           training_frame,
                           model_id = NULL,
                           nfolds = 0,
                           seed = -1,
                           fold_assignment = c("AUTO", "Random", "Modulo", "Stratified"),
                           fold_column = NULL,
                           keep_cross_validation_models = TRUE,
                           keep_cross_validation_predictions = FALSE,
                           keep_cross_validation_fold_assignment = FALSE,
                           validation_frame = NULL,
                           ignore_const_cols = TRUE,
                           score_each_iteration = FALSE,
                           balance_classes = FALSE,
                           class_sampling_factors = NULL,
                           max_after_balance_size = 5.0,
                           laplace = 0,
                           threshold = 0.001,
                           min_sdev = 0.001,
                           eps = 0,
                           eps_sdev = 0,
                           min_prob = 0.001,
                           eps_prob = 0,
                           compute_metrics = TRUE,
                           max_runtime_secs = 0,
                           export_checkpoints_dir = NULL,
                           gainslift_bins = -1,
                           auc_type = c("AUTO", "NONE", "MACRO_OVR", "WEIGHTED_OVR", "MACRO_OVO", "WEIGHTED_OVO"))
{
  # Validate required training_frame first and other frame args: should be a valid key or an H2OFrame object
  training_frame <- .validate.H2OFrame(training_frame, required=TRUE)
  validation_frame <- .validate.H2OFrame(validation_frame, required=FALSE)

  # Validate other required args
  # If x is missing, then assume user wants to use all columns as features.
  if (missing(x)) {
     if (is.numeric(y)) {
         x <- setdiff(col(training_frame), y)
     } else {
         x <- setdiff(colnames(training_frame), y)
     }
  }

  # Validate other args
  .naivebayes.map <- c("x" = "ignored_columns", "y" = "response_column", 
                       "threshold" = "min_sdev", "eps" = "eps_sdev")

  # Build parameter list to send to model builder
  parms <- list()
  parms$training_frame <- training_frame
  args <- .verify_dataxy(training_frame, x, y)
  if( !missing(fold_column) && !is.null(fold_column)) args$x_ignore <- args$x_ignore[!( fold_column == args$x_ignore )]
  parms$ignored_columns <- args$x_ignore
  parms$response_column <- args$y

  if (!missing(model_id))
    parms$model_id <- model_id
  if (!missing(nfolds))
    parms$nfolds <- nfolds
  if (!missing(seed))
    parms$seed <- seed
  if (!missing(fold_assignment))
    parms$fold_assignment <- fold_assignment
  if (!missing(fold_column))
    parms$fold_column <- fold_column
  if (!missing(keep_cross_validation_models))
    parms$keep_cross_validation_models <- keep_cross_validation_models
  if (!missing(keep_cross_validation_predictions))
    parms$keep_cross_validation_predictions <- keep_cross_validation_predictions
  if (!missing(keep_cross_validation_fold_assignment))
    parms$keep_cross_validation_fold_assignment <- keep_cross_validation_fold_assignment
  if (!missing(validation_frame))
    parms$validation_frame <- validation_frame
  if (!missing(ignore_const_cols))
    parms$ignore_const_cols <- ignore_const_cols
  if (!missing(score_each_iteration))
    parms$score_each_iteration <- score_each_iteration
  if (!missing(balance_classes))
    parms$balance_classes <- balance_classes
  if (!missing(class_sampling_factors))
    parms$class_sampling_factors <- class_sampling_factors
  if (!missing(max_after_balance_size))
    parms$max_after_balance_size <- max_after_balance_size
  if (!missing(laplace))
    parms$laplace <- laplace
  if (!missing(min_sdev))
    parms$min_sdev <- min_sdev
  if (!missing(eps_sdev))
    parms$eps_sdev <- eps_sdev
  if (!missing(min_prob))
    parms$min_prob <- min_prob
  if (!missing(eps_prob))
    parms$eps_prob <- eps_prob
  if (!missing(compute_metrics))
    parms$compute_metrics <- compute_metrics
  if (!missing(max_runtime_secs))
    parms$max_runtime_secs <- max_runtime_secs
  if (!missing(export_checkpoints_dir))
    parms$export_checkpoints_dir <- export_checkpoints_dir
  if (!missing(gainslift_bins))
    parms$gainslift_bins <- gainslift_bins
  if (!missing(auc_type))
    parms$auc_type <- auc_type

  if (!missing(threshold) && missing(min_sdev)) {
    warning("argument 'threshold' is deprecated; use 'min_sdev' instead.")
    parms$min_sdev <- threshold
  }
  if (!missing(eps) && missing(eps_sdev)) {
    warning("argument 'eps' is deprecated; use 'eps_sdev' instead.")
    parms$eps_sdev <- eps
  }

  # Error check and build model
  model <- .h2o.modelJob('naivebayes', parms, h2oRestApiVersion=3, verbose=FALSE)
  return(model)
}
.h2o.train_segments_naivebayes <- function(x,
                                           y,
                                           training_frame,
                                           nfolds = 0,
                                           seed = -1,
                                           fold_assignment = c("AUTO", "Random", "Modulo", "Stratified"),
                                           fold_column = NULL,
                                           keep_cross_validation_models = TRUE,
                                           keep_cross_validation_predictions = FALSE,
                                           keep_cross_validation_fold_assignment = FALSE,
                                           validation_frame = NULL,
                                           ignore_const_cols = TRUE,
                                           score_each_iteration = FALSE,
                                           balance_classes = FALSE,
                                           class_sampling_factors = NULL,
                                           max_after_balance_size = 5.0,
                                           laplace = 0,
                                           threshold = 0.001,
                                           min_sdev = 0.001,
                                           eps = 0,
                                           eps_sdev = 0,
                                           min_prob = 0.001,
                                           eps_prob = 0,
                                           compute_metrics = TRUE,
                                           max_runtime_secs = 0,
                                           export_checkpoints_dir = NULL,
                                           gainslift_bins = -1,
                                           auc_type = c("AUTO", "NONE", "MACRO_OVR", "WEIGHTED_OVR", "MACRO_OVO", "WEIGHTED_OVO"),
                                           segment_columns = NULL,
                                           segment_models_id = NULL,
                                           parallelism = 1)
{
  # formally define variables that were excluded from function parameters
  model_id <- NULL
  verbose <- NULL
  destination_key <- NULL
  # Validate required training_frame first and other frame args: should be a valid key or an H2OFrame object
  training_frame <- .validate.H2OFrame(training_frame, required=TRUE)
  validation_frame <- .validate.H2OFrame(validation_frame, required=FALSE)

  # Validate other required args
  # If x is missing, then assume user wants to use all columns as features.
  if (missing(x)) {
     if (is.numeric(y)) {
         x <- setdiff(col(training_frame), y)
     } else {
         x <- setdiff(colnames(training_frame), y)
     }
  }

  # Validate other args
  .naivebayes.map <- c("x" = "ignored_columns", "y" = "response_column", 
                       "threshold" = "min_sdev", "eps" = "eps_sdev")

  # Build parameter list to send to model builder
  parms <- list()
  parms$training_frame <- training_frame
  args <- .verify_dataxy(training_frame, x, y)
  if( !missing(fold_column) && !is.null(fold_column)) args$x_ignore <- args$x_ignore[!( fold_column == args$x_ignore )]
  parms$ignored_columns <- args$x_ignore
  parms$response_column <- args$y

  if (!missing(nfolds))
    parms$nfolds <- nfolds
  if (!missing(seed))
    parms$seed <- seed
  if (!missing(fold_assignment))
    parms$fold_assignment <- fold_assignment
  if (!missing(fold_column))
    parms$fold_column <- fold_column
  if (!missing(keep_cross_validation_models))
    parms$keep_cross_validation_models <- keep_cross_validation_models
  if (!missing(keep_cross_validation_predictions))
    parms$keep_cross_validation_predictions <- keep_cross_validation_predictions
  if (!missing(keep_cross_validation_fold_assignment))
    parms$keep_cross_validation_fold_assignment <- keep_cross_validation_fold_assignment
  if (!missing(validation_frame))
    parms$validation_frame <- validation_frame
  if (!missing(ignore_const_cols))
    parms$ignore_const_cols <- ignore_const_cols
  if (!missing(score_each_iteration))
    parms$score_each_iteration <- score_each_iteration
  if (!missing(balance_classes))
    parms$balance_classes <- balance_classes
  if (!missing(class_sampling_factors))
    parms$class_sampling_factors <- class_sampling_factors
  if (!missing(max_after_balance_size))
    parms$max_after_balance_size <- max_after_balance_size
  if (!missing(laplace))
    parms$laplace <- laplace
  if (!missing(min_sdev))
    parms$min_sdev <- min_sdev
  if (!missing(eps_sdev))
    parms$eps_sdev <- eps_sdev
  if (!missing(min_prob))
    parms$min_prob <- min_prob
  if (!missing(eps_prob))
    parms$eps_prob <- eps_prob
  if (!missing(compute_metrics))
    parms$compute_metrics <- compute_metrics
  if (!missing(max_runtime_secs))
    parms$max_runtime_secs <- max_runtime_secs
  if (!missing(export_checkpoints_dir))
    parms$export_checkpoints_dir <- export_checkpoints_dir
  if (!missing(gainslift_bins))
    parms$gainslift_bins <- gainslift_bins
  if (!missing(auc_type))
    parms$auc_type <- auc_type

  if (!missing(threshold) && missing(min_sdev)) {
    warning("argument 'threshold' is deprecated; use 'min_sdev' instead.")
    parms$min_sdev <- threshold
  }
  if (!missing(eps) && missing(eps_sdev)) {
    warning("argument 'eps' is deprecated; use 'eps_sdev' instead.")
    parms$eps_sdev <- eps
  }

  # Build segment-models specific parameters
  segment_parms <- list()
  if (!missing(segment_columns))
    segment_parms$segment_columns <- segment_columns
  if (!missing(segment_models_id))
    segment_parms$segment_models_id <- segment_models_id
  segment_parms$parallelism <- parallelism

  # Error check and build segment models
  segment_models <- .h2o.segmentModelsJob('naivebayes', segment_parms, parms, h2oRestApiVersion=3)
  return(segment_models)
}
