
clear

ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
EFPrediction_ResFolder = [ReplicationFolder '/results/PredictionAnalysis/AtlasLoading/2Fold_RandomCV_EFAccuracy'];
Behavior = load([ReplicationFolder '/results/PredictionAnalysis/Behavior_693.mat']);
for i = 0:99
    i
    Prediction_Fold0 = load([EFPrediction_ResFolder '/Time_' num2str(i) '/Fold_0_Score.mat']);
    MAE_Actual_Fold0 = Prediction_Fold0.MAE;
    Index_Fold0 = Prediction_Fold0.Index + 1;
    Prediction_Fold1 = load([EFPrediction_ResFolder '/Time_' num2str(i) '/Fold_1_Score.mat']);
    MAE_Actual_Fold1 = Prediction_Fold1.MAE;
    Index_Fold1 = Prediction_Fold1.Index + 1;

    % Fold 0
    EFAccuracy_Fold0 = Behavior.F1_Exec_Comp_Res_Accuracy(Index_Fold0);
    Age_Fold0 = Behavior.AgeYears(Index_Fold0);
    Sex_Fold0 = Behavior.Sex(Index_Fold0);
    Motion_Fold0 = Behavior.Motion(Index_Fold0);
    % Fold 1
    EFAccuracy_Fold1 = Behavior.F1_Exec_Comp_Res_Accuracy(Index_Fold1);
    Age_Fold1 = Behavior.AgeYears(Index_Fold1);
    Sex_Fold1 = Behavior.Sex(Index_Fold1);
    Motion_Fold1 = Behavior.Motion(Index_Fold1);

    [ParCorr_Actual_Fold0, ~] = partialcorr(Prediction_Fold0.Predict_Score', EFAccuracy_Fold0, double([Age_Fold0 Sex_Fold0 Motion_Fold0]));
    [ParCorr_Actual_Fold1, ~] = partialcorr(Prediction_Fold1.Predict_Score', EFAccuracy_Fold1, double([Age_Fold1 Sex_Fold1 Motion_Fold1]));
    
    ParCorr_Actual_RandomCV(i + 1) = mean([ParCorr_Actual_Fold0, ParCorr_Actual_Fold1]);
    MAE_Actual_RandomCV(i + 1) = mean([MAE_Actual_Fold0, MAE_Actual_Fold1]);
end
ParCorr_Actual_RandomCV_Mean = mean(ParCorr_Actual_RandomCV);
MAE_Actual_RandomCV_Mean = mean(MAE_Actual_RandomCV);
save([EFPrediction_ResFolder '/2Fold_RandomCV_ParCorr_MAE.mat'], 'ParCorr_Actual_RandomCV', 'MAE_Actual_RandomCV', 'ParCorr_Actual_RandomCV_Mean', 'MAE_Actual_RandomCV_Mean');

% Permutation test
EFPrediction_Permutation_ResFolder = [ReplicationFolder '/results/PredictionAnalysis/AtlasLoading/2Fold_RandomCV_EFAccuracy_Permutation'];
for i = 0:999
    i
    Prediction_Fold0 = load([EFPrediction_Permutation_ResFolder '/Time_' num2str(i) '/Fold_0_Score.mat']);
    MAE_Permutation_Fold0 = Prediction_Fold0.MAE;
    Index_Fold0 = Prediction_Fold0.Index + 1;
    Prediction_Fold1 = load([EFPrediction_Permutation_ResFolder '/Time_' num2str(i) '/Fold_1_Score.mat']);
    MAE_Permutation_Fold1 = Prediction_Fold1.MAE;
    Index_Fold1 = Prediction_Fold1.Index + 1;

    % Fold 0
    EFAccuracy_Fold0 = Behavior.F1_Exec_Comp_Res_Accuracy(Index_Fold0);
    Age_Fold0 = Behavior.AgeYears(Index_Fold0);
    Sex_Fold0 = Behavior.Sex(Index_Fold0);
    Motion_Fold0 = Behavior.Motion(Index_Fold0);
    % Fold 1
    EFAccuracy_Fold1 = Behavior.F1_Exec_Comp_Res_Accuracy(Index_Fold1);
    Age_Fold1 = Behavior.AgeYears(Index_Fold1);
    Sex_Fold1 = Behavior.Sex(Index_Fold1);
    Motion_Fold1 = Behavior.Motion(Index_Fold1);

    [ParCorr_Permutation_Fold0, ~] = partialcorr(Prediction_Fold0.Predict_Score', EFAccuracy_Fold0, double([Age_Fold0 Sex_Fold0 Motion_Fold0]));
    [ParCorr_Permutation_Fold1, ~] = partialcorr(Prediction_Fold1.Predict_Score', EFAccuracy_Fold1, double([Age_Fold1 Sex_Fold1 Motion_Fold1]));

    ParCorr_Permutation_RandomCV(i + 1) = mean([ParCorr_Permutation_Fold0, ParCorr_Permutation_Fold1]);
    MAE_Permutation_RandomCV(i + 1) = mean([MAE_Permutation_Fold0, MAE_Permutation_Fold1]);
end
ParCorr_Permutation_RandomCV_Mean = mean(ParCorr_Permutation_RandomCV);
MAE_Permutation_RandomCV_Mean = mean(MAE_Permutation_RandomCV);
save([EFPrediction_Permutation_ResFolder '/2Fold_RandomCV_ParCorr_MAE_Permutation.mat'], 'ParCorr_Permutation_RandomCV', 'MAE_Permutation_RandomCV', 'ParCorr_Permutation_RandomCV_Mean', 'MAE_Permutation_RandomCV_Mean');
