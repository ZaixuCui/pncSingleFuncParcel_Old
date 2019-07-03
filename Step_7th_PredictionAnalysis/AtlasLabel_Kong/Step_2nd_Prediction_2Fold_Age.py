
import scipy.io as sio
import numpy as np
import os
import sys
sys.path.append('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/scripts_Final/Functions');
import Ridge_CZ_Sort_CategoricalFeatures

PredictionFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/PredictionAnalysis';
AtlasLabel_Folder = PredictionFolder + '/AtlasLabel_Kong';
# Import data
AtlasLabel_Mat = sio.loadmat(AtlasLabel_Folder + '/AtlasLabel_All.mat');
Behavior_Mat = sio.loadmat(PredictionFolder + '/Behavior_693.mat');
SubjectsData = AtlasLabel_Mat['AtlasLabel_All'];
AgeYears = Behavior_Mat['AgeYears'];
AgeYears = np.transpose(AgeYears);
# Range of parameters
Alpha_Range = np.exp2(np.arange(16) - 10);

FoldQuantity = 2;

ResultantFolder = AtlasLabel_Folder + '/2Fold_Sort_Age';
Ridge_CZ_Sort_CategoricalFeatures.Ridge_KFold_Sort(SubjectsData, AgeYears, FoldQuantity, Alpha_Range, ResultantFolder, 1, 0);

# Permutation test, 1,000 times
Times_IDRange = np.arange(1000);
ResultantFolder = AtlasLabel_Folder + '/2Fold_Sort_Permutation_Age';
Ridge_CZ_Sort_CategoricalFeatures.Ridge_KFold_Sort_Permutation(SubjectsData, AgeYears, Times_IDRange, FoldQuantity, Alpha_Range, ResultantFolder, 1, 1000, 'all.q')
